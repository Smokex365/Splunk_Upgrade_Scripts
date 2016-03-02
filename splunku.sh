#!/bin/bash
 
# Created by Michael Chamberland
# Site: http://www.aramblinggeek.com/shell-script-splunk-syslog-server-update-script/
# Version: 1.14
# Last Updated: 3/2/2016 5:12AM
# What it does: Checks for the upgrade file. If not found it downloads
# the latest version indicated by the sdl and si variables and runs the
# upgrade: If the file is present it runs the upgrade.
 
# To get the variables go to the appropiate download page
# and select the wget link. You'll need to update this manually
# for each release since splunk does not provide a easy way to
# retrieve the latest version without requiring a new link for each release.
 
# Full Link
sdl='http://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=6.3.3&product=splunk&filename=splunk-6.3.3-f44afce176d0-linux-2.6-x86_64.rpm&wget=true'
md5dl='http://download.splunk.com/products/splunk/releases/6.3.3/splunk/linux/splunk-6.3.3-f44afce176d0-linux-2.6-x86_64.rpm.md5'
# File Name
si='splunk-6.3.3-f44afce176d0-linux-2.6-x86_64.rpm'
md5='splunk-6.3.3-f44afce176d0-linux-2.6-x86_64.rpm.md5'
 
# Checks for the Splunk file
if [ ! -e $si ]
    then
        # Initiates download in background
        echo -n "Downloading $si:"
        while ((wget -q -O $si $sdl || wget -q -O $md5 $md5dl))
            do wait
             
        # Runs upgrade
        /opt/splunk/bin/splunk stop
        rpm -U $si
        # Default is to accept license and ignore configuration checks
        /opt/splunk/bin/splunk start --accept-license --answer-yes
        echo "Removing File"
        rm -rf $si
        echo "Update Complete"
        done
    else
        /opt/splunk/bin/splunk stop
        dpkg -U $si
        # Default is to accept license and ignore configuration checks
        /opt/splunk/bin/splunk start --accept-license --answer-yes
        echo "Removing File"
        rm -rf $si
        echo "Update Complete"
fi
