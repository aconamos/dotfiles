# Installation
Assumes two things:
1. You have a working `apt` (and `sudo` privileges)
2. You have cloned this repository into your home directory (`~/dotfiles`)

Will install the following packages with `apt`:
- gcc
- cmake
- fish

Will install Rust using `rustup`, and install the following packages:
- eza
- starship

Will create the following directories/files:
- `~/dotfile_bk_TIMESTAMP`
- `~/.cargo` (as a consequence of installing Rust) 

Will backup and link the following directories/files:
- `~/.config`
- `~/.tmux`
- `~/.tmux.conf`
- `~/.vim`
- `~/.vimrc`
- `~/.zshrc`

> [!WARNING]
> This script will change your user's shell to `fish`. If you don't want this, make
> sure to modify it or change it back immediately after.

> [!CAUTION]
> This script will change your `.zshrc` to immediately enter `fish`. This is probably
> a bad change and will be fixed later.
