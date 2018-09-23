#!/bin/bash

echo "This script will install vimrc, colors and plugins to your home directory!"

date=`date "+%Y%m%d"`

# Step 1: backup .vim
#--------------------------------------------------------------------------------------
if [ -d ~/.vim ] ; then
    echo "backup .vim"
    rm -rf ~/.vim_backup_$date
    mv ~/.vim ~/.vim_backup_$date
    mkdir ~/.vim
else
    mkdir ~/.vim
fi
#--------------------------------------------------------------------------------------



# Step 2: install colors
#--------------------------------------------------------------------------------------
cp -r colors ~/.vim/
#--------------------------------------------------------------------------------------



# Step 3: install plugins
#--------------------------------------------------------------------------------------
plugins=`ls plugins/*.zip 2> /dev/null`
if [ -n "$plugins" ] ; then
    echo "The plugins is below:"
    for i in $plugins;
    do
        echo -e "\t$i"
    done

    # if there's unzip command
    type unzip > /dev/null 2>&1
    if [ "$?" == "1" ] ; then
        echo "There's no unzip command, should use apt to install unzip..."
        sudo apt install unzip
    fi

    # unzip each plugin
    for i in $plugins;
    do
        echo "install $i ..."
        unzip $i -d ~/.vim
    done
else
    echo "There's no plugins to install!"
fi
#--------------------------------------------------------------------------------------



# Step 4: install needed applications
#--------------------------------------------------------------------------------------
# if there's ctags command
type ctags > /dev/null 2>&1
if [ "$?" == "1" ] ; then
    echo "There's no ctags command, should use apt to install ctags..."
    sudo apt install exuberant-ctags
fi
#--------------------------------------------------------------------------------------



# Step 5: install vimrc
#--------------------------------------------------------------------------------------
if [ -f ~/.vimrc ] ; then
    echo "backup .vimrc"
    mv ~/.vimrc ~/.vimrc_backup_$date
fi
echo "install .vimrc"
cp vimrc ~/.vimrc
#--------------------------------------------------------------------------------------

echo "Install complete!!! Enjoy yourself! -_-"

