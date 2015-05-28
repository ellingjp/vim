vim
===

Holds my vimrc.

Requires vim-plug by junegunn (https://github.com/junegunn/vim-plug)

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

Install:

```bash
git clone https://github.com/ellingjp/vim.git ~/.local/src/vimrc
ln -s ~/.vimrcrepo/vimrc ~/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c "PlugInstall | qall"
```
