#!/bin/bash
 
# Created by Michael Chamberland
# Site: http://aramblinggeek.wordpress.com
# Version: 1.12
# Last Updated: 4/20/2013 6:45PM
# What it does: This script checks for a new version of the upgrade
# script of my Dropbox account.
 
# 1. If the upgrade script is not found in the local folder it will
#        download it from the web.
# 2. If the upgrade script is found then it checks the MD5 checksums
#       against the version downloaded from the web. If they are different
#       it keeps the web version, otherwise it will keep the current copy.
#
# Once all checks have finished it will prompt the user to update and if
#       user confirms it will run the upgrade.
 
# Checks for Splunk upgrade script. If not found, download from dropbox.
# If found, proceed to MD5 checks.
if [ ! -f 'splunku.sh' ]
    then
    wget -q --secure-protocol='auto' -O 'splunku.sh' 'https://www.dropbox.com/s/vl825c0zczp84xm/splunku.sh?dl=1'
    chmod u+x splunku.sh
else
    wget -q --secure-protocol='auto' -O 'splunku.sh.tmp' 'https://www.dropbox.com/s/vl825c0zczp84xm/splunku.sh?dl=1'
    chmod u+x splunku.sh.tmp
    md5t=`md5sum splunku.sh.tmp | cut -c 1-32`
    md5o=`md5sum splunku.sh | cut -c 1-32`
    echo "Checking Upgrade Script MD5"
    if [ $md5t == $md5o ]
        then
        # MD5 matches: Removes slunku.sh.tmp
        echo "MD5 Matches. Continuing..."
        rm -rf splunku.sh.tmp
    else
        # MD5 does not match: replace splunku.sh with downloaded version.
        echo "MD5 Mismatch. Replacing file."
        rm -rf splunku.sh
        mv splunku.sh.tmp splunku.sh
    fi
fi
 
# Prompts user whether they want to run the upgrade
read -rep "Do you want to run the upgrade for Splunk? [y|n]: " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
    then
    sh ./splunku.sh
    printf '\n'
fi
