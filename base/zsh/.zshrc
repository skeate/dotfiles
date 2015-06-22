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

# }}}
# Prompt/Theme ------------------------------------------------------------- {{{

antigen theme ys

# }}}
# Completions -------------------------------------------------------------- {{{

autoload -U compinit
compinit
source /usr/share/nvm/bash_completion

# }}}
# Misc Settings ------------------------------------------------------------ {{{

setopt HIST_IGNORE_DUPS
setopt extendedglob

source /usr/share/nvm/nvm.sh

# Help {{{

autoload -U run-help
autoload run-help-git
unalias run-help
alias help=run-help

# }}}

# }}}