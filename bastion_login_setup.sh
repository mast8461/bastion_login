#!/bin/bash
if [[ $(uname -s) = Darwin ]]
then
        OPEN=open
else
        OPEN=xdg-open
fi
echo What is your sso username? 
read SSO
echo Where is your bastion SSH key? ex. '~/.ssh/id_rsa'
read SSHKEY
if [[ ! -d '$HOME/.local/bin' ]]
then mkdir -p $HOME/.local/bin
fi
echo "#!/bin/bash
if [[ -z "$1" ]]
then 
        REGION=dfw1
elif [[ \$1 = iad ]]
then
        REGION=iad3
elif [[ \$1 = ord ]]
then
        REGION=ord1
elif [[ \$1 = dfw ]]
then
        REGION=dfw1
elif [[ \$1 = lon3 ]]
then
        REGION=lon3
elif [[ \$1 = lon5 ]]
then
        REGION=lon5
elif [[ \$1 = hkg ]]
then
        REGION=hkg1
elif [[ \$1 = syd ]]
then
        REGION=syd2
elif [[ \$1 = '--help' ]]
then 
        echo \"Usage: 
'bastion' will log you into the dfw bastion. 
'bastion <region>' will log you into the specified bastion. 
Available regions: 
iad, dfw, ord, hkg, syd, lon3, lon5\" ; exit
elif [[ \$1 = '-h' ]]
then 
        ehco \"Usage: 
'bastion' will log you into the dfw bastion. 
'bastion <region>' will log you into the specified bastion. 
Available regions: 
iad, dfw, ord, hkg, syd, lon3, lon5\" ; exit
else
        REGION=dfw1
fi


ssh $SSO@cbast.\$REGION.corp.rackspace.net -i $SSHKEY
RC=\$?; if [[ \$RC = 0 ]]; then
        exit
else
        $OPEN https://rax.io/auth-\$REGION
        echo 'Authenticate then press [ENTER]'
        read -n1 s 2> /dev/null
        ssh $SSO@cbast.\$REGION.corp.rackspace.net -i $SSHKEY
fi
" > $HOME/.local/bin/bastion
chmod +x $HOME/.local/bin/bastion
if [ ! -f ~/.ssh/config ]
then :
else mv -i ~/.ssh/config ~/.ssh/config.bak1
fi
echo "Host cbast.dfw1.corp.rackspace.net
    ForwardAgent yes
    ForwardX11Trusted yes
    ProxyCommand none
    User $SSO
    ControlMaster auto
    ControlPath ~/.ssh/master-%r@%h:%p
    TCPKeepAlive yes
    ServerAliveInterval 300

Host cbast.ord1.corp.rackspace.net
    ForwardAgent yes
    ForwardX11Trusted yes
    ProxyCommand none
    User $SSO
    ControlMaster auto
    ControlPath ~/.ssh/master-%r@%h:%p
    TCPKeepAlive yes
    ServerAliveInterval 300

Host cbast.hkg1.corp.rackspace.net
    ForwardAgent yes
    ForwardX11Trusted yes
    ProxyCommand none
    User $SSO
    ControlMaster auto
    ControlPath ~/.ssh/master-%r@%h:%p
    TCPKeepAlive yes
    ServerAliveInterval 300

Host cbast.iad3.corp.rackspace.net
    ForwardAgent yes
    ForwardX11Trusted yes
    ProxyCommand none
    User $SSO
    ControlMaster auto
    ControlPath ~/.ssh/master-%r@%h:%p
    TCPKeepAlive yes
    ServerAliveInterval 300

Host cbast.ord1.corp.rackspace.net
    ForwardAgent yes
    ForwardX11Trusted yes
    ProxyCommand none
    User $SSO
    ControlMaster auto
    ControlPath ~/.ssh/master-%r@%h:%p
    TCPKeepAlive yes
    ServerAliveInterval 300

Host cbast.syd2.corp.rackspace.net
    ForwardAgent yes
    ForwardX11Trusted yes
    ProxyCommand none
    User $SSO
    ControlMaster auto
    ControlPath ~/.ssh/master-%r@%h:%p
    TCPKeepAlive yes
    ServerAliveInterval 300
    
    Host *
    ProxyCommand ssh -A cbast.dfw1.corp.rackspace.net 'nc %h %p'
    ForwardX11Trusted yes
    GSSAPIAuthentication no
    StrictHostKeyChecking no
    VerifyHostKeyDNS no
    HashKnownHosts no
    TCPKeepAlive yes
    ServerAliveInterval 300
" >> ~/.ssh/config
echo "Complete. Make sure '~/.local/bin/' is in your PATH"
