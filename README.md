vim
===

Holds my vimrc.

Installation<br>

Unix-like:<br>
1. git clone https://github.com/ellingjp/vim.git ~/.vimrcrepo<br>
2. cd ~ && ln -s ./.vimrcrepo/vimrc ~/.vimrc<br>
3. git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim<br>
4. Open vim, run :PluginInstall<br>


Windows Vista+:
You must have admin privileges and curl installed to the path (for Vundle, see http://www.confusedbycode.com/curl/#downloads).
The rest is the same, but use mklink instead of ln -s:

 mklink /h "_vimrc" "C:\path\to\repo\_vimrc"
