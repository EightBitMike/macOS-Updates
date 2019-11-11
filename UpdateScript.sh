#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# Install all reccomended software updates, will notify user that updates have been 
# installed and they should reboot to finish the installation. 
# v1.2 08/09/2019
#  - changed notification dialog to ensure users don't think they are being forced to reboot
#  - modified method of looking for recommended security updates, see lines 35-41
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# USER DEFINED VARIABLES
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

orgName="MyOrg"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# SYSTEM VARIABLES
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
notifyIcon="/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/ToolbarInfo.icns"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# APPLICATION
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 


# assign title 
title="${orgName} | Title message you want to display"

# check for reccomended 
updates=$(/usr/sbin/softwareupdate -l)
getsecupd="$(echo "$updates" | /usr/bin/grep -B1 recommended | /usr/bin/grep -v recommended | grep Security | sed -n 's/   \* //p')"

# setup our text
if 
	[[ "$getsecupd" =~ "Security" ]];
then
	/usr/sbin/softwareupdate -i "$getsecupd" && text=$( echo "The text that will appear in the Jamf window." )
	# display notification to end user with information regarding reboot
	"${jamfHelper}" -windowType utility -title "${title}" -icon "${notifyIcon}" -description "${text}" -button1 "OK" -defaultButton 1
else
	exit 0
fi

exit 0