#!/bin/bash
 
# Created by Michael Chamberland
# Site: http://aramblinggeek.wordpress.com
# Version: 1.13
# Last Updated: 4/20/2013 6:45PM
# What it does: Checks for the upgrade file. If not found it downloads
# the latest version indicated by the sdl and si variables and runs the
# upgrade: If the file is present it runs the upgrade.
 
# To get the variables go to the appropiate download page
# and select the wget link. You'll need to update this manually
# for each release since splunk does not provide a easy way to
# retrieve the latest version without requiring a new link for each release.
 
# Full Link
sdl='http://www.splunk.com/page/download_track?file=5.0.4/splunk/linux/splunk-5.0.4-172409-linux-2.6-intel.deb&ac=&wget=true&name=wget&typed=releases&elq=9dfb1435-edc1-4a49-8552-50166f16eecf'
md5dl='http://www.splunk.com/page/download_track?file=5.0.4/splunk/linux/splunk-5.0.4-172409-linux-2.6-intel.deb.md5&ac=&wget=true&name=wget&typed=releases'
# File Name
si='splunk-5.0.4-172409-linux-2.6-intel.deb'
md5='splunk-5.0.4-172409-linux-2.6-intel.deb.md5'
 
# Checks for the Splunk file
if [ ! -e $si ]
    then
        # Initiates download in background
        echo -n "Downloading $si:"
        while ((wget -q -O $si $sdl || wget -q -O $md5 $md5dl))
            do wait
             
        # Runs upgrade
        /opt/splunk/bin/splunk stop
        dpkg -i $si
        # Default is to accept license and ignore configuration checks
        /opt/splunk/bin/splunk start --accept-license --answer-yes
        echo "Removing File"
        rm -rf $si
        echo "Update Complete"
        done
    else
        /opt/splunk/bin/splunk stop
        dpkg -i $si
        # Default is to accept license and ignore configuration checks
        /opt/splunk/bin/splunk start --accept-license --answer-yes
        echo "Removing File"
        rm -rf $si
        echo "Update Complete"
fi
