export XDG_CONFIG_HOME="$HOME/.config"
export  XDG_CACHE_HOME="$HOME/.cache"
export   XDG_DATA_HOME="$HOME/.local/share"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

export EDITOR=nvim
export HISTFILE="$XDG_CACHE_HOME/zsh_history"
export PAGER=less

if hash ag 2> /dev/null
then
  export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"
  export ACK_PAGER_COLOR="less -x4SRFX"
fi

export LESSHISTFILE="$XDG_CACHE_HOME/less_history"

export NVM_DIR="$XDG_DATA_HOME/nvm"
export CARGO_DIR="$HOME/.cargo/bin"
export PATH="$PATH:$NVM_DIR:$CARGO_DIR"
