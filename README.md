vim
===

Holds my vimrc.

Installation

Unix-like:
1. git clone https://github.com/ellingjp/vim.git ~/.vimrcrepo
2. cd ~ && ln -s ./.vimrcrepo/vimrc ~/.vimrc
3. git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
4. Open vim, run :PluginInstall


Windows Vista+:
You must have admin privileges and curl installed to the path (for Vundle).
The rest is the same, but use mklink instead of ln -s:

 mklink /j "C:\path\to\_vimrc" "vimrc"
