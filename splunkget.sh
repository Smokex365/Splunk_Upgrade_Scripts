#!/bin/bash
 
# Created by Michael Chamberland
# Site: http://www.aramblinggeek.com/shell-script-splunk-syslog-server-update-script/

if [ ! -f 'splunku.sh' ]
    then
    wget -q --secure-protocol='auto' -O 'splunku.sh' 'https://raw.github.com/Smokex365/Splunk_Upgrade_Scripts/master/splunku.sh'
    chmod u+x splunku.sh
else
    wget -q --secure-protocol='auto' -O 'splunku.sh.tmp' 'https://raw.github.com/Smokex365/Splunk_Upgrade_Scripts/master/splunku.sh'
    chmod u+x splunku.sh.tmp
    md5t=`md5sum splunku.sh.tmp | cut -c 1-32`
    md5o=`md5sum splunku.sh | cut -c 1-32`
    echo "Checking MD5 Checksums..."
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
read -p "Do you want to run the upgrade for Splunk? [y|n]" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
    then
    sh ./splunku.sh
    printf '\n'
fi
