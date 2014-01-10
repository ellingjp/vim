""" Setup script for Vim.  After running, Vim should have a working copy
    of Vundle and be ready to go. 
    
    This script, by default will try to make some educated guesses
    about where to clone Vundle files (ie, the user's vim plugin directory).
    Should probably add the ability to let the user choose.
    
    This script assumes a working copy of Git.  For Windows users,
    the git folder must be in the path.  Must use Windows Vista+ for Symlink
    support.
    
    WARNING     Right now, this script blindly copies over the following
                files:
                    (Windows Only) %GitInstallDirectory%\cmd\curl.cmd
                    $HOME/.vimrc, or on windows %Home%\_vimrc
"""
import os
import os.path
import subprocess
import shutil

vundledir = "./vundlestuff"
windows = "nt"
system = os.name
home = os.path.expanduser('~')
vimdir = "unset"
vundlerepo = "https://github.com/gmarik/vundle.git"
curlfile = os.path.join(os.path.dirname(os.path.abspath(__file__)), "curl.cmd")
vimrc = os.path.join(os.path.dirname(os.path.abspath(__file__)), "vimrc")

# If running windows, try to copy curl.cmd into the git binaries folder
if (system == windows):
    print("Attempting to copy curl.cmd to git directory...")
    if os.path.isdir("C:\Program Files\Git"):
        shutil.copyfile(curlfile, "C:\Program Files\Git\cmd\curl.cmd")
    elif os.path.isdir("C:\Program Files (x86)\Git"):
        shutil.copyfile(curlfile, "C:\Program Files (x86)\Git\cmd\curl.cmd")
    else:
        print("Failed to copy curl.cmd.  Try running as admin.")

# check if either directory exists, if so use that:
if os.path.isdir(home + "/vimfiles"):
    vimdir = home + "/vimfiles"
if os.path.isdir(home + "/.vim"):
    if vimdir != "unset":
        vimdir = "both"
    else:
        vimdir = home + "/.vim"

# if vimdir hasn't been set, or both directories exist, use OS:
if (vimdir == "unset" or vimdir == "both"):
    # try to use vimfiles if on windows (will be overriden if .vim exists):
    if (system == windows):
        vimdir = home + "/vimfiles"
    else:
        vimdir = home + "/.vim"

# clone vundle if it doesn't already exist
if not os.path.isdir(vimdir + "/bundle/vundle"):
    print("Vundle directory doesn't exist, cloning...")
    subprocess.call(['git', 'clone', vundlerepo, vimdir+"/bundle/vundle"])
else:
    print("Vundle repo already exists, not cloning")

# copy vimrc
print("Making symlink in home directory to vimrc file")
if (system == windows):
    os.symlink(vimrc, home + "/_vimrc")
else:
    os.symlink(vimrc, home + "/.vimrc")
