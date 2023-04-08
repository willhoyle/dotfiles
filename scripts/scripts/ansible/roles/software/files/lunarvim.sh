#!/bin/bash
# A hack to fix the lunarvim install script
# it looks for tree-sitter but it's already installed by neovim 
# js package and then fails
#
# python=$HOMEBREW_PREFIX/bin/python3

# node deps
npm i -g neovim

# python deps
# eval "$python -m pip install pynvim"

# rust deps
# brew install ripgrep

yes | bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
