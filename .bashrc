# Load / setup nvm
[ -s "/Users/skeate/.nvm/nvm.sh" ] && . "/Users/skeate/.nvm/nvm.sh"
nvm use v0.10

export EDITOR=vim
source ~/.git-prompt.sh

# Colorize prompt
PS1="\[\033[35m\]\t \[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h\n\[\033[36m\]\$(__git_ps1) \[\033[33;1m\]\w\[\033[m\]\n\$ "

# Configure aliases
alias ll='ls -l'

# put /usr/local/bin at start of path
PATH=/usr/local/bin:$PATH:~/bin

# ** recursive directory globbing
shopt -s globstar
