# .zshrc
# Created by Jonathan Skeate

# Antigen ------------------------------------------------------------------ {{{

[[ -z $XDG_DATA_HOME ]] && echo 'data home not set' && return

if [[ ! -f $XDG_DATA_HOME/zsh/antigen.zsh ]]; then
  echo " ** Antigen not found **"
  echo "Making $XDG_DATA_HOME/zsh if it doesn't exist..."
  mkdir -p $XDG_DATA_HOME/zsh
  echo "Downloading antigen..."
  curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh \
    > $XDG_DATA_HOME/zsh/antigen.zsh
fi
source $XDG_DATA_HOME/zsh/antigen.zsh
antigen use oh-my-zsh

# }}}
# Plugins ------------------------------------------------------------------ {{{

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions src
antigen bundle git
antigen bundle sharat87/autoenv # auto-execs .env files when CDing into dir
antigen bundle archlinux # pacman/yaourt shortcuts
antigen bundle bower # bower aliases/completion
antigen bundle git-extras
antigen bundle gitfast
antigen bundle meteor
antigen bundle node
antigen bundle npm
antigen bundle sudo
antigen bundle vagrant
antigen bundle dircycle
antigen bundle systemd

# }}}
# Prompt/Theme ------------------------------------------------------------- {{{

antigen theme ys

# }}}
# Path Config -------------------------------------------------------------- {{{

export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$GEM_HOME/bin"
export PATH="$PATH:$HOME/.local/lib/nodejs/bin"

# }}}
# Completions -------------------------------------------------------------- {{{

autoload -U compinit
compinit
[ -s $NVM_DIR/bash_completion ] && . $NVM_DIR/bash_completion
[ -s /usr/share/nvm/bash_completion ] && . /usr/share/nvm/bash_completion

# }}}
# Misc Settings ------------------------------------------------------------ {{{

setopt HIST_IGNORE_DUPS
setopt extendedglob

alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'

[ -s "$NVM_DIR/nvm.sh" ] && . $NVM_DIR/nvm.sh
[ -s "/usr/share/nvm/nvm.sh" ] && . "/usr/share/nvm/nvm.sh"
nvm use stable

eval "$(thefuck --alias)"

alias vim='nvim'

# Help {{{

autoload -U run-help
autoload run-help-git
unalias run-help
alias help=run-help

# }}}

# }}}

eval "`npm completion`"

[ -s "/usr/share/nvm/nvm.sh" ] && . "/usr/share/nvm/nvm.sh"
