# vim:fdm=marker
# .zshrc
# Created by Jonathan Skeate

# zgen --------------------------------------------------------------------- {{{

[[ -z $XDG_DATA_HOME ]] && echo 'data home not set' && return

if [[ ! -f $XDG_DATA_HOME/zsh/zgen/zgen.zsh ]]; then
  echo " ** zgen not found **"
  echo "Making $XDG_DATA_HOME/zsh if it doesn't exist..."
  mkdir -p $XDG_DATA_HOME/zsh
  echo "Downloading zgen..."
  git clone https://github.com/tarjoilija/zgen.git $XDG_DATA_HOME/zsh/zgen
fi
source $XDG_DATA_HOME/zsh/zgen/zgen.zsh

# }}}
# Plugins ------------------------------------------------------------------ {{{

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa id_router mosh_rsa github_id_rsa

if ! zgen saved; then
  zgen oh-my-zsh

  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/gitfast
  zgen oh-my-zsh plugins/git-extras
  zgen oh-my-zsh plugins/npm
  zgen oh-my-zsh plugins/ssh-agent
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/systemd
  zgen oh-my-zsh plugins/tmux

  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-completions src

  zgen oh-my-zsh themes/ys

  zgen save
fi

# }}}
# Path Config -------------------------------------------------------------- {{{

export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$GEM_HOME/bin"
export PATH="$PATH:$HOME/.local/lib/nodejs/bin"

# }}}
# Completions -------------------------------------------------------------- {{{

autoload bashcompinit
bashcompinit
sourceIfExists() {
  [ -s $1 ] && . $1
}
sourceIfExists $XDG_DATA_HOME/nvm/bash_completion
sourceIfExists /usr/share/nvm/bash_completion
sourceIfExists ~/.local/lib/dots/contrib/bash_completion
eval "$(npm completion)"

# }}}
# NVM {{{

# https://medium.com/@dannysmith/little-thing-2-speeding-up-zsh-f1860390f92
nvm() {
  echo "🚨 NVM not loaded! Loading now..."
  unset -f nvm
  sourceIfExists $XDG_DATA_HOME/nvm/nvm.sh
  sourceIfExists /usr/share/nvm/nvm.sh
  nvm "$@"
}

# commented out because this makes cd incredibly slow
# autoload -U add-zsh-hook
# load-nvmrc() {
#   local node_version="$(nvm version)"
#   local nvmrc_path="$(nvm_find_nvmrc)"

#   if [ -n "$nvmrc_path" ]; then
#     local nvm_rc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

#     if [ "$nvmrc_node_version" != "N/A" ] && [ "$nvmrc_node_version" != "$node_version" ]; then
#       nvm use
#     fi
#   elif [ "$node_version" != "$(nvm version default)" ]; then
#     echo "Reverting to nvm default version"
#     nvm use default
#   fi
# }
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

# }}}
# Misc Settings ------------------------------------------------------------ {{{

setopt HIST_IGNORE_DUPS
setopt extendedglob
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# python virtualenvwrapper
mkdir -p $XDG_DATA_HOME/virtualenvs
export WORKON_HOME=$XDG_DATA_HOME/virtualenvs
export PROJECT_HOME=$HOME/Code
sourceIfExists /usr/bin/virtualenvwrapper.sh

eval "$(thefuck --alias)"
[[ $(</proc/$PPID/cmdline) == *qterminal* ]] && export TERM="xterm-256color"

function nvim() {
  if test $# -gt 0; then
    env nvim "$@"
  elif test -f Session.vim; then
    env nvim -S
  else
    env nvim
  fi
}

# Help {{{

autoload -U run-help
autoload run-help-git
unalias run-help

# }}}

# }}}
# Functions ---------------------------------------------------------------- {{{

# Codi
# Usage: codi [filetype] [filename]
codi() {
  local syntax="${1:-python}"
  shift
  nvim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}

# }}}
# Aliases ------------------------------------------------------------------ {{{

sourceIfExists $XDG_CONFIG_HOME/zsh/aliases

# }}}
