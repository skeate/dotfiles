export XDG_CONFIG_HOME="$HOME/.config"
export  XDG_CACHE_HOME="$HOME/.cache"
export   XDG_DATA_HOME="$HOME/.local/share"

export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export EDITOR=vim
export TERMINAL=urxvt
export HISTFILE="$XDG_CACHE_HOME/zsh_history"
export PAGER=less

if hash ag 2> /dev/null
then
  export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"
  export ACK_PAGER_COLOR="less -x4SRFX"
fi

if hash gem 2> /dev/null
then
  export GEMRC="$XDG_CONFIG_HOME/gemrc/config"
  export GEM_HOME="$HOME/.local/lib/ruby/gems/$(ruby -e 'puts RbConfig::CONFIG["ruby_version"]')"
  export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem/specs"
fi

if hash npm 2> /dev/null
then
  export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
fi

export LESSHISTFILE="$XDG_CACHE_HOME/less_history"

export NVM_DIR="$XDG_DATA_HOME/nvm"
