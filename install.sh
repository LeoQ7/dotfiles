#!/bin/bash

is_installed() {
	command -v "$1" >/dev/null 2>&1
}

start() {
    clear
    winip=$(ip route | grep default | awk '{print $3}')
    export ALL_PROXY="http://${winip}:7890"
    export all_proxy="http://${winip}:7890"
    echo "Set Proxy: ${ALL_PROXY}"
    curl ip.gs
    echo "Modifying /etc/apt/sources.list"
    echo IyDpu5jorqTms6jph4rkuobmupDnoIHplZzlg4/ku6Xmj5Dpq5ggYXB0IHVwZGF0ZSDpgJ/luqbvvIzlpoLmnInpnIDopoHlj6/oh6rooYzlj5bmtojms6jph4oKZGViIGh0dHBzOi8vbWlycm9ycy50dW5hLnRzaW5naHVhLmVkdS5jbi91YnVudHUvIGZvY2FsIG1haW4gcmVzdHJpY3RlZCB1bml2ZXJzZSBtdWx0aXZlcnNlCiMgZGViLXNyYyBodHRwczovL21pcnJvcnMudHVuYS50c2luZ2h1YS5lZHUuY24vdWJ1bnR1LyBmb2NhbCBtYWluIHJlc3RyaWN0ZWQgdW5pdmVyc2UgbXVsdGl2ZXJzZQpkZWIgaHR0cHM6Ly9taXJyb3JzLnR1bmEudHNpbmdodWEuZWR1LmNuL3VidW50dS8gZm9jYWwtdXBkYXRlcyBtYWluIHJlc3RyaWN0ZWQgdW5pdmVyc2UgbXVsdGl2ZXJzZQojIGRlYi1zcmMgaHR0cHM6Ly9taXJyb3JzLnR1bmEudHNpbmdodWEuZWR1LmNuL3VidW50dS8gZm9jYWwtdXBkYXRlcyBtYWluIHJlc3RyaWN0ZWQgdW5pdmVyc2UgbXVsdGl2ZXJzZQpkZWIgaHR0cHM6Ly9taXJyb3JzLnR1bmEudHNpbmdodWEuZWR1LmNuL3VidW50dS8gZm9jYWwtYmFja3BvcnRzIG1haW4gcmVzdHJpY3RlZCB1bml2ZXJzZSBtdWx0aXZlcnNlCiMgZGViLXNyYyBodHRwczovL21pcnJvcnMudHVuYS50c2luZ2h1YS5lZHUuY24vdWJ1bnR1LyBmb2NhbC1iYWNrcG9ydHMgbWFpbiByZXN0cmljdGVkIHVuaXZlcnNlIG11bHRpdmVyc2UKZGViIGh0dHBzOi8vbWlycm9ycy50dW5hLnRzaW5naHVhLmVkdS5jbi91YnVudHUvIGZvY2FsLXNlY3VyaXR5IG1haW4gcmVzdHJpY3RlZCB1bml2ZXJzZSBtdWx0aXZlcnNlCiMgZGViLXNyYyBodHRwczovL21pcnJvcnMudHVuYS50c2luZ2h1YS5lZHUuY24vdWJ1bnR1LyBmb2NhbC1zZWN1cml0eSBtYWluIHJlc3RyaWN0ZWQgdW5pdmVyc2UgbXVsdGl2ZXJzZQoKIyDpooTlj5HluIPova/ku7bmupDvvIzkuI3lu7rorq7lkK/nlKgKIyBkZWIgaHR0cHM6Ly9taXJyb3JzLnR1bmEudHNpbmdodWEuZWR1LmNuL3VidW50dS8gZm9jYWwtcHJvcG9zZWQgbWFpbiByZXN0cmljdGVkIHVuaXZlcnNlIG11bHRpdmVyc2UKIyBkZWItc3JjIGh0dHBzOi8vbWlycm9ycy50dW5hLnRzaW5naHVhLmVkdS5jbi91YnVudHUvIGZvY2FsLXByb3Bvc2VkIG1haW4gcmVzdHJpY3RlZCB1bml2ZXJzZSBtdWx0aXZlcnNl | base64 -d | sudo tee /etc/apt/sources.list
    echo "==========================================================="
    echo ""
    echo -n "* The setup will begin in 5 seconds... "
    sleep 5
    echo -n "Times up! Here we start!"
    echo ""
    cd $HOME
}

install-linux-packages() {
    echo "==========================================================="
    echo "* Install following packages:"
    echo "-----------------------------------------------------------"

    sudo apt update
    sudo apt install -y deborphan aptitude apt-file
    sudo apt install -y python3-dev python3-pip python3-setuptools
    sudo apt install -y build-essential libreadline-dev
    sudo apt install -y zsh fish curl wget git tree unzip ncdu tmux trash-cli
    sudo apt install -y festival festvox-kallpc16k
    sudo apt install -y neofetch screenfetch autojump
    sudo apt install -y lsof whois traceroute
    sudo apt install -y net-tools iputils-tracepath dnsutils
    sudo apt install -y netcat-openbsd fonts-noto fonts-noto-hinted fonts-noto-cjk
    sudo apt install -y tldr neovim ripgrep
    sudo apt install -y libgit2-dev rustc rbenv
}

setup-omz() {
    echo "-----------------------------------------------------------"
    echo "* Installing OMF... "
    echo "-----------------------------------------------------------"
    # install oh-my-zsh
    if [ -d "$HOME/.config/omf" ]; then
        echo "oh-my-fish already installed"
    else
        echo "Installing oh-my-fish..."
        curl -L https://get.oh-my.fish | fish

        echo "Installing plugins..."
        omf install fzf
        omf install https://github.com/jhillyerd/plugin-git
    fi
    mkdir -p ~/.config/fish
    ln -s ~/.dotfiles/config.fish ~/.config/fish/config.fish
    ln -s ~/.dotfiles/fishfunctions ~/.config/fish/functions
    ln -s ~/.dotfiles/starship.toml ~/.config/starship.toml
    ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf

    # change default shell
    if [[ "$SHELL" == *"fish"* ]]; then
        echo "Fish already set as default shell"
    else
        echo "Setting default shell to Fish"
        chsh -s "$(command -v fish)"
    fi
    # starship theme
    if is_installed starship; then
        echo "Starship theme already installed"
    else
        echo "Installing Starship theme 🚀"
        curl -fsSL https://starship.rs/install.sh | bash
        ln -s ~/.dotfiles/starship.toml ~/.config/starship.toml
    fi
    ln -s ~/.dotfiles/aliases ~/.aliases
}

install-nvim(){
    mkdir -p ~/.config/nvim/
    mkdir -p ~/.local/share/nvim/plugged
    ln -s ~/.dotfiles/init.vim ~/.config/nvim/
    ln -s ~/.dotfiles/init.vim ~/.vimrc
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

setup-git() {
    echo "==========================================================="
    echo "                        Setup git                          "
    echo "-----------------------------------------------------------"
    git config --global user.name Q7
    git config --global user.email q71998@gmail.com
    git config --global core.editor nvim
    git config --global merge.conflictstyle diff3
    git config --global mergetool.vimdiff.path $(which nvim)
    git config --global merge.tool 'vimdiff'
    git config --global commit.gpgsign true
    git config --global user.signingkey BCE73303DEC0E80F
    # git config --global https.proxy socks5h://127.0.0.1:1080
    git config --global core.excludesfile ~/.gitignore_global
    # Stash without GPG signing: https://stackoverflow.com/a/24429205
    git config --global alias.stashq '-c commit.gpgsign=false stash'
}

setup-git() {
    echo "==========================================================="
    echo "                       Setup cargo                         "
    echo "-----------------------------------------------------------"
    mkdir -p ~/.cargo
    echo W3NvdXJjZS5jcmF0ZXMtaW9dCnJlcGxhY2Utd2l0aCA9ICd0dW5hJwoKW3NvdXJjZS50dW5hXQpyZWdpc3RyeSA9ICJodHRwczovL21pcnJvcnMudHVuYS50c2luZ2h1YS5lZHUuY24vZ2l0L2NyYXRlcy5pby1pbmRleC5naXQiCg== | base64 -d | tee ~/.cargo/config
    cargo install bat # cat
    cargo install dua-cli # du
    cargo install exa # ls
}

upgrade-packages() {
    echo "==========================================================="
    echo "                      Upgrade packages                     "
    echo "-----------------------------------------------------------"

    sudo apt update && sudo apt upgrade -y
}

finish() {
    echo "==========================================================="
    echo "> Do not forget:"
    echo ""
    echo "- set up neovim"
    echo "- install Anaconda"
    echo "- install exa, zoxide"
    echo "==========================================================="
}

start
install-linux-packages
setup-omf
install-nvim
setup-git
setup-cargo
upgrade-packages
finish