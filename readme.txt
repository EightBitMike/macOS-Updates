The workflow for this is as follows:

- Deploy the .xml file as an Extension Attribute
- Create a smart group on that Extension Attribute where the regex does/does not equal 1 or more
- Deploy the shell script to the machines based on your smartgroup output (e.g. if the EA outputs one, deploy the script)

Even if you were to apply the update script to your entire org, ignoring the second step, the prompt wouldn't appear as they don't meet the if/then requirement. Their machine would just have a softwareupdate command pushed to it.