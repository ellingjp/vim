vim
===

Holds my vimrc.

Requires vim-plug by junegunn (https://github.com/junegunn/vim-plug)

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

Install:

```bash
git clone https://github.com/ellingjp/vim.git ~/.local/src/vimrc</li>
ln -s ~/.vimrcrepo/vimrc ~/.vimrc</li>
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim</li>
vim -c "PlugInstall | qall"</li>
```
