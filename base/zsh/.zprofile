export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY="latest_installed"
