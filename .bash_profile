# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 022

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# the rest of this file is commented out.

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=/usr/local/bin:~/bin:"${PATH}"
fi

#PATH="${PATH}"

# do the same with MANPATH
#if [ -d ~/man ]; then
#    MANPATH=~/man${MANPATH:-:}
#    export MANPATH
#fi

# OPAM configuration
. /home/khheo/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
. "$HOME/.cargo/env"
