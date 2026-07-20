#!/bin/bash
set -e

# install oh-my-zsh
if [[ ! -d $HOME/.oh-my-zsh ]]; then
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

ln -s -f $(pwd)/.zshrc ~/.zshrc
ln -s -f $(pwd)/.tmux.conf ~/.tmux.conf
ln -s -f $(pwd)/.tmux.conf.local ~/.tmux.conf.local
ln -s -f $(pwd)/nvim ~/.config/nvim
ln -s -f $(pwd)/.pylintrc ~/.pylintrc

# python support for neovim
pip3 install pynvim
