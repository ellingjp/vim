vim
===

Holds my vimrc.

Installation<br>

Unix-like:
<ol>
 <1i>git clone https://github.com/ellingjp/vim.git ~/.vimrcrepo</li>
 <li>cd ~ && ln -s ./.vimrcrepo/vimrc ~/.vimrc</li>
 <li>git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim</li>
 <li>Open vim, run :PluginInstall</li>
</ol>


Windows Vista+:
You must have admin privileges and curl installed to the path (for Vundle, see http://www.confusedbycode.com/curl/#downloads).
The rest is the same, but use mklink instead of ln -s:

 mklink /h "_vimrc" "C:\path\to\repo\_vimrc"
