#!/usr/bin/env bash
echo "This installation script assumes debian. It should work on anything debian-based, as well."
read -p "Confirm to continue (y/n): " confirm

if [[ $confirm != 'y' ]]; then
    echo "Quitting!"
    exit
fi
echo "Continuing!"

install_deps() {
    if ! apt --version > /dev/null; then
        echo "apt not installed. Exiting now..."
        exit 1
    fi

    # Lazy method
    echo "Running install command instead of checking for packages first (lazy method)..."
    sudo apt install gcc cmake fish
}

install_rust_things() {
    # Plagiarized from github/JJGO/dotfiles/shell-setup.sh
    if [[ ! -d $HOME/.rustup ]]; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y || exit 1
    fi

    for crate in eza starship; do
        $HOME/.cargo/bin/cargo install $crate
    done
}


install_deps
install_rust_things

# This isn't going to play well on some systems. Too lazy to fix it right now, though.
chsh -s /usr/bin/fish
# This 'cd' is worth noting. Just, like, look at it. And think about your directory. And where you are, man. Crazy.
cd
# This section of the script is also mostly plagiarized from github/JJGO.
OLD_DOTFILES="dotfile_bk_$(date -u +"%Y%m%d%H%M%S")"
mkdir $OLD_DOTFILES

backup() {
    if [ -f $1 ]; then
        mv $1 $OLD_DOTFILES
    fi
    if [ -d $1 ]; then
        mv $1 $OLD_DOTFILES
    fi
}

for dir in ~/.config ~/.tmux ~/.tmux.conf ~/.vim ~/.vimrc ~/.zshrc; do
    backup $dir
    rm -rf $dir
done

ln -sf dotfiles/dot-config ~/.config
ln -sf dotfiles/dot-tmux ~/.tmux
ln -sf dotfiles/dot-tmux.conf ~/.tmux.conf
ln -sf dotfiles/dot-vim ~/.vim
ln -sf dotfiles/dot-vimrc ~/.vimrc
ln -sf dotfiles/dot-zshrc ~/.zshrc

# Go into the tmux config, and pull the tpm module
cd .tmux.conf
git submodule update --init --recursive

