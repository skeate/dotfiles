# .zshrc
# Created by Jonathan Skeate

# Antigen ------------------------------------------------------------------ {{{

if [ ! -f ~/.zsh/antigen.zsh ]; then
  echo " ** Antigen not found **"
  echo "Making ~/.zsh if it doesn't exist..."
  mkdir -p ~/.zsh
  echo "Downloading antigen..."
  curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh \
    > ~/.zsh/antigen.zsh
fi
source ~/.zsh/antigen.zsh
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

antigen theme bureau

# }}}
# Completions -------------------------------------------------------------- {{{

autoload -U compinit
compinit

# }}}
# Misc Settings ------------------------------------------------------------ {{{

setopt HIST_IGNORE_DUPS
export EDITOR=vim
PATH=/usr/local/bin:$PATH:~/bin

# Help {{{

autoload -U run-help
autoload run-help-git
unalias run-help
alias help=run-help

# }}}

# }}}
