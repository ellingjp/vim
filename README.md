vim
===

Holds my vimrc.

Requires vim-plug by junegunn (https://github.com/junegunn/vim-plug)<br><br>

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

Install:
<ol>
 <li>git clone https://github.com/ellingjp/vim.git ~/.local/src/vimrc</li>
 <li>ln -s ~/.vimrcrepo/vimrc ~/.vimrc</li>
 <li>curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim</li>
 <li>vim -c "PlugInstall | qall"</li>
</ol>
