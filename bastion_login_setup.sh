#!/bin/bash

if [[ $(uname -s) = Darwin ]]
then
        OPEN=open; PRO=~/.bash_profile
else
        OPEN=xdg-open; PRO=~/.bashrc
fi
echo What is your sso username? 
read SSO
echo Where is your bastion SSH key?
read SSHKEY
echo "#!/bin/bash
if [[ \$1 = iad ]]
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
else
        REGION=dfw1
fi


ssh $SSO@cbast.\$REGION.corp.rackspace.net -i $SSHKEY
RC=\$?; if [[ \$RC = 0 ]]; then
        exit
else
        \$OPEN https://rax.io/auth-\$REGION
        echo 'Authenticate then press [ENTER]'
        read -n1 s 2> /dev/null
        ssh $SSO@cbast.\$REGION.corp.rackspace.net -i $SSHKEY
fi
" > $HOME/.local/bin/bastion
chmod +x $HOME/.local/bin/bastion
mv -i ~/.ssh/config ~/.ssh/config.bak1
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
