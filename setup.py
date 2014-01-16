from __future__ import print_function
import sys
import os
import os.path
import subprocess
import shutil
import argparse

def warning(*objs):
    print("WARNING: ", *objs, end='\n', file=sys.stderr)

# argument parsing
parser = argparse.ArgumentParser()
parser.add_argument("-v", "--verbose", help="specify verbosity", 
                    action="store_true")
parser.add_argument("--vim-dir", help="specify vimfiles directory")
parser.add_argument("--git-dir", help="(windows only) specify where to look\
                    for git files (ex C:\Program Files\Git)")
parser.add_argument("--vimrc-path", help="specify vimrc path", default="~")
parser.add_argument("--vimrc-copy", choices=["sym", "copy", "none"], 
                    default="sym", help="specify how to copy the vimrc to\
                    vimdir (symlink, hard copy [overwrites any existing file\
                    !], or none)")
parser.add_argument("--no-curl", action="store_true",
                    help="(windows only) don't try to install curl")
parser.add_argument("--no-admin", action="store_true",
                    help="try to install curl with no admin priviledges.\
                          warning: this will create a user PATH variable\
                          which will hide the system PATH variable.\
                          thus, changes to the system PATH will not be\
                          reflected.  run with --del-path to fix.")
parser.add_argument("--del-path", action="store_true",
                    help="(windows only) removes user-local PATH variable\
                          created with --no-admin.")
parser.add_argument("--no-vundle", action="store_true", 
                    help="don't try to clone vundle")
args = parser.parse_args()

# constants
vundlerepo = "https://github.com/gmarik/vundle.git"
windows = "nt"
setupdir = os.path.dirname(os.path.abspath(__file__))
curlfile = os.path.join(setupdir, "curl.cmd")
vimrc = os.path.join(setupdir, "vimrc")

system = os.name
home = os.path.expanduser('~')

# see if we should delete user local PATH
if (args.del_path and system == windows):
    subprocess.call(['setx', 'PATH', '""', '-m'])
    sys.exit()
elif (args.del_path and system != windows):
    print("Error: --no-admin called on non-windows platform, quitting")
    sys.exit()
    
# If running windows, try to copy curl.cmd into the git binaries folder
if (args.no_curl):
    if args.verbose: print("--no-curl specified.  Skipping curl install.")
elif (system != windows):
    if args.verbose: print("Not windows.  Skipping curl install.")
elif (system == windows):
    if (args.no_admin):
        print("Trying to install curl.cmd locally, with no admin priviledges...")
        subprocess.call(['setx', 'PATH', '%PATH%;'+setupdir])
        
    else:
        print("Trying to install curl.cmd...")
        if (args.git_dir):
            gdir = args.git_dir + "/cmd"
        elif os.path.isdir("C:\Program Files\Git"):
            gdir = "C:\Program Files\Git"
        elif os.path.isdir("C:\Program Files (x86)\Git"):
            gdir = "C:\Program Files (x86)\Git"
        else:
            print("Could not find git installation directory!")
        
        if args.verbose:
            print("Attempting to copy curl.cmd to", gdir)

        try:
            shutil.copyfile(curlfile, gdir)
        except PermissionError as err:
            warning("curl not installed, insufficient permissions. try running as admin, or install manually.")
        except IOError as err:
            warning("curl not installed, io error:",err)
        else:
            print("curl successfully installed.")

print()

# set vim directory
if (args.vim_dir):                      # first check if user set vimdir
    vimdir = args.vim_dir
elif os.path.isdir(home + "/.vim"):     # check if .vim already exists
    if args.verbose: print("found ~/.vim")
    vimdir = home + "/.vim"
elif os.path.isdir(home + "/vimfiles"): # check if /vimfiles exists
    if args.verbose: print("found ~/vimfiles")
    vimdir = home + "/vimfiles"
else:                                   # use OS to determine
    if (system == windows):
        if args.verbose: print("windows system, using ~/vimfiles")
        vimdir = home + "/vimfiles"
    else:
        if args.verbose: print("nonwindows system, using ~/.vim")
        vimdir = home + "/.vim"

print("vim directory set to", vimdir)

print()

# clone vundle if it doesn't already exist
if (args.no_vundle):
    print("--no-vundle chosen, skipping vundle clone...")
else:
    if not os.path.isdir(vimdir + "/bundle/vundle"):
        print("Cloning Vundle into", vimdir+"/bundle/vundle")
        subprocess.call(['git','clone',vundlerepo,vimdir+"/bundle/vundle"])
    else:
        warning("Vundle repo already exists, not cloning")

print()

# copy vimrc
if (args.vimrc_path):
    user_vimrc = args.vimrc_path
elif (system == windows):
    if args.verbose: print("windows system found, using ~/_vimrc")
    user_vimrc = "/_vimrc"
else:
    if args.verbose: print("nonwindows system found, using ~/.vimrc")
    user_vimrc = "/.vimrc"

if (args.vimrc_copy == "sym"):
    print("Making symlink in home directory to vimrc file")
    try:
        os.symlink(vimrc, home + "/.vimrc")
    except OSError as err:
        warning("OSError:", err)
elif (args.vimrc_copy == "copy"):
    print("Making copy in home directory of vimrc file")
    try: 
        shutil.copyfile(vimrc, user_vimrc)
    except IOError as err:
        warning("IO error:", err)
else:
    if args.verbose: print("Not copying vimrc")

print("All finished!")
