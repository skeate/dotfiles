# .zshrc
# Created by Jonathan Skeate

# Antigen ------------------------------------------------------------------ {{{

if [ ! -f ~/.zsh/antigen.zsh ]; then
  echo "Making ~/.zsh if it doesn't exist..."
  mkdir -p ~/.zsh
  echo "Downloading antigen..."
  curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh > ~/.zsh/antigen.zsh
fi
source ~/.zsh/antigen.zsh

# }}}
# Plugins ------------------------------------------------------------------ {{{

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git
antigen bundle sharat87/autoenv

# }}}
# Prompt ------------------------------------------------------------------- {{{


# }}}
