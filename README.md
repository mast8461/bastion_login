# bastion_login
This is a bash script that makes it easy to log into the next gen bastion servers for service net troubleshooting.

When used, if you are not authenticated to the bastion, a new tab in your default browser will be opened and prompt you to authenticate. Once you have authenticated, press ENTER when focused on your terminal and you will be logged in to the specified bastion. 

If you have an ssh config file, it will be moved to ~/.ssh/config.bak1 and a new one will be created.
To install 'chmod +744' on bastion_login_setup.sh and execute. 
Make sure ~/.local/bin/ is in your $PATH. 

Usage: 
'bastion -h' or 'bastion --help' will display these usage options.
'bastion' will log you into the dfw bastion. 
'bastion <region>' will log you into the specified bastion. 
Available regions: 
iad, dfw, ord, hkg, syd, lon3, lon5
