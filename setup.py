""" Setup script for Vim.  After running, Vim should have a working copy
    of Vundle and be ready to go. 
    
    This script, by default will try to make some educated guesses
    about where to clone Vundle files (ie, the user's vim plugin directory).
    Should probably add the ability to let the user choose.
    
    This script assumes a working copy of Git.  For Windows users,
    the git folder must be in the path.
    
    WARNING     Right now, this script blindly copies over the following
                files:
                    (Windows Only) %GitInstallDirectory%\cmd\curl.cmd
                    $HOME/.vimrc, or on windows %Home%\_vimrc
"""

import os
from subprocess import call
from os.path import expanduser, isdir, join, dirname
from shutil import copyfile

vundledir = "./vundlestuff"
windows = "nt"
os = os.name
home = expanduser('~')
vimdir = "unset"
vundlerepo = "https://github.com/gmarik/vundle.git"
curlfile = join(dirname(__file__), "curl.cmd")
vimrc = join(dirname(__file__), "vimrc")

# If running windows, try to copy curl.cmd into the git binaries folder
if (os == windows):
    print("Attempting to copy curl.cmd to git directory...")
    if isdir("C:\Program Files\Git"):
        copyfile(curlfile, "C:\Program Files\Git\cmd\curl.cmd")
    elif isdir("C:\Program Files (x86)\Git"):
        copyfile(curlfile, "C:\Program Files (x86)\Git\cmd\curl.cmd")
    else:
        print("Failed to copy curl.cmd.  Try running as admin.")

# check if either directory exists, if so use that:
if isdir(home + "/vimfiles"):
    vimdir = home + "/vimfiles"
if isdir(home + "/.vim"):
    if vimdir != "unset":
        vimdir = "both"
    else:
        vimdir = home + "/.vim"

# if vimdir hasn't been set, or both directories exist, use OS:
if (vimdir == "unset" or vimdir == "both"):
    # try to use vimfiles if on windows (will be overriden if .vim exists):
    if (os == windows):
        vimdir = home + "/vimfiles"
    else:
        vimdir = home + "/.vim"

# clone vundle if it doesn't already exist
if not isdir(vimdir + "/bundle/vundle"):
    print("Vundle directory doesn't exist, cloning...")
    call(['git', 'clone', vundlerepo, vimdir])
else:
    print("Vundle repo already exists, not cloning")

# copy vimrc
if (os == windows):
    copyfile(vimrc, home + "_vimrc")
else:
    copyfile(vimrc, home + ".vimrc")
