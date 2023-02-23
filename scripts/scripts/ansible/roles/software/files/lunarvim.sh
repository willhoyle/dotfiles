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

yes | LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/fc6873809934917b470bff1b072171879899a36b/utils/installer/install.sh | sed '/tree-sitter-cli/d') "" --no-install-dependencies
