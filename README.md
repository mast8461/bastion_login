# bastion_login
This is a bash script that makes it easy to log into the next gen bastion servers for service net troubleshooting.
If you have an ssh config file, this will move it to ~/.ssh/config.bak1 and create a new one.
To install 'chmod +744' on bastion_login_setup.sh and execute. 
Make sure ~/.local/bin/ is in your PATH.
Usage: 
'bastion' will log you into the dfw bastion. 
'bastion <region>' will log you into the specified bastion. 
Available regions: 
iad, dfw, ord, hkg, syd, lon3, lon5
