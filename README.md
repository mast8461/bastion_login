# bastion_login
This is a bash script that makes it easy to log into the next gen bastion servers for service net troubleshooting.
This will move your current ~/.ssh/config file to ~/.ssh/config.bak and create a new one. It will also create an alias named 'bastion' in your ~/.basrc. 
To install 'chmod +744' on bastion_login_setup.sh and execute. 
Usage: 
'bastion' will log you into the dfw bastion. 
'bastion <region>' will log you into the specified bastion. 
Available regions: 
iad, dfw, ord,hkg, syd, lon3, lon5
