#!/bin/bash

# Update apt and install zsh, curl
apt update -y
apt install zsh curl -y

# FzF fuzzy reverse search
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Copy over our theme, hushlogin and our .zsh files
cp .zsh_theme ~/.oh-my-zsh/themes/dstn.zsh-theme
cp .zshrc .zsh_funcs .zsh_kube .hushlogin ~