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
 
# Links
sdl='http://www.splunk.com/page/download_track?file=5.0.3/splunk/linux/splunk-5.0.3-163460-linux-2.6-intel.deb&ac=&wget=true&name=wget&typed=releases&elq=9dfb1435-edc1-4a49-8552-50166f16eecf'
md5dl='http://www.splunk.com/page/download_track?file=5.0.3/splunk/linux/splunk-5.0.3-163460-linux-2.6-intel.deb.md5&ac=&wget=true&name=wget&typed=releases'
# File Name(s)
si='splunk-5.0.3-163460-linux-2.6-intel.deb'
md5='splunk-5.0.3-163460-linux-2.6-intel.deb.md5'
# Commands
md5c=$( md5sum $md5 )
 
# Checks for the Splunk file
if [ ! -e $si ]
    then
        # Initiates download in background
        echo "Downloading $si and Checksum:"
        while ((wget -q -O $si $sdl && wget -q -O $md5 $md5dl))
            do wait
            if  [ 'md5sum --status $md5' ]
                then
                    # Runs upgrade
                    #/opt/splunk/bin/splunk stop
                    #dpkg -i $si
                    # Default is to accept license and ignore configuration checks
                    #/opt/splunk/bin/splunk start --accept-license --answer-yes
                    echo "Removing File -1"
                    #rm -rf $si
                    echo "Update Complete -1"
                else
                    echo "MD5 Failed: File may be corrupted -1"
                    exit
            fi
        done
    else
        if [ $md5c ]
            then
                # Runs upgrade
                #/opt/splunk/bin/splunk stop
                #dpkg -i $si
                # Default is to accept license and ignore configuration checks
                #/opt/splunk/bin/splunk start --accept-license --answer-yes
                echo "Removing File -2"
                #rm -rf $si
                echo "Update Complete -2"
            else
                echo "MD5 Failed: File may be corrupted -2"
                exit
        fi
fi
