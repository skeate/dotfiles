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
# Z ------------------------------------------------------------------------ {{{

if [[ ! -f $XDG_DATA_HOME/zsh/z.sh ]]; then
  echo " ** z not found **"
  echo "Downloading z..."
  curl -L https://raw.githubusercontent.com/rupa/z/master/z.sh \
    > $XDG_DATA_HOME/zsh/z.sh
fi
#source $XDG_DATA_HOME/zsh/z.sh

# }}}
# Plugins ------------------------------------------------------------------ {{{

if ! zgen saved; then
  zgen oh-my-zsh

  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/archlinux # pacman/yaourt shortcuts
  zgen oh-my-zsh plugins/bower # bower aliases/completion
  zgen oh-my-zsh plugins/git-extras
  zgen oh-my-zsh plugins/gitfast
  zgen oh-my-zsh plugins/meteor
  zgen oh-my-zsh plugins/node
  zgen oh-my-zsh plugins/npm
  zgen oh-my-zsh plugins/ssh-agent
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/vagrant
  zgen oh-my-zsh plugins/dircycle
  zgen oh-my-zsh plugins/systemd

  zgen load sharat87/autoenv # auto-execs .env files when CDing into dir
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-completions src

  zgen oh-my-zsh themes/ys

  zgen save
fi

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa id_router mosh_rsa github_id_rsa

# }}}
# Path Config -------------------------------------------------------------- {{{

export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$GEM_HOME/bin"
export PATH="$PATH:$HOME/.local/lib/nodejs/bin"

# }}}
# Completions -------------------------------------------------------------- {{{

sourceIfExists() {
  [ -s $1 ] && . $1
}
sourceIfExists /usr/share/nvm/bash_completion
sourceIfExists ~/.local/lib/dots/contrib/bash_completion

# }}}
# Misc Settings ------------------------------------------------------------ {{{

setopt HIST_IGNORE_DUPS
setopt extendedglob
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

source /usr/share/nvm/nvm.sh
source /usr/share/nvm/install-nvm-exec
nvm use stable
eval "$(npm completion)"

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
    env nvim -c Obsession
  fi
}

# Help {{{

autoload -U run-help
autoload run-help-git
unalias run-help

# }}}

# }}}
# Aliases ------------------------------------------------------------------ {{{

alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
alias help=run-help
alias glr='git pull --rebase'

# }}}
# SSH Agent ---------------------------------------------------------------- {{{

if ! pgrep -u $USER ssh-agent > /dev/null; then
  ssh-agent > $XDG_CACHE_HOME/.ssh-agent-thing
fi
eval $(<$XDG_CACHE_HOME/.ssh-agent-thing)

# }}}
