#!/bin/bash
#This will setup a script that will help you log into the next gen bastions easier. 
#This will move your current .ssh/config file to .ssh/config.bak and create a new one. 
echo What is your sso username? 
read SSO
echo "#!/bin/bash
#usage: 'bastion <region>'
#Available regions: 
#iad
#dfw
#ord
#hkg
#syd
#lon3
#lon5
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

if [[ $(uname -s) = Darwin ]]
then
        OPEN=open
else
        OPEN=xdg-open
fi

ssh $SSO@cbast.\$REGION.corp.rackspace.net
RC=\$?; if [[ \$RC = 0 ]]; then
        exit
else
        \$OPEN https://rax.io/auth-\$REGION
        echo 'Authenticate then press [ENTER]'
        read -n1 s 2> /dev/null
        ssh $SSO@cbast.\$REGION.corp.rackspace.net
fi
" > bastionlogin.sh
chmod +x bastionlogin.sh
mv ~/.ssh/config ~/.ssh/config.bak
echo "Host cbast.dfw1.corp.rackspace.net
    ForwardAgent yes
    ForwardX11Trusted yes
    ProxyCommand none
    User $SSO
    ControlMaster auto
    ControlPath ~/.ssh/master-%r@%h:%p
    TCPKeepAlive yes
    ServerAliveInterval 300
    #
    # Most techs run a terminal permanently open to the bastion
    # which serves as the MUX socket; if you do not do this,
    # uncomment the below to have the first MUX created tossed
    # into the background instead (man ssh -> "-O ctl_cmd")
    # ControlPersist 10h

Host cbast.ord1.corp.rackspace.net
    ForwardAgent yes
    ForwardX11Trusted yes
    ProxyCommand none
    User $SSO
    ControlMaster auto
    ControlPath ~/.ssh/master-%r@%h:%p
    TCPKeepAlive yes
    ServerAliveInterval 300
    #
    # Most techs run a terminal permanently open to the bastion
    # which serves as the MUX socket; if you do not do this,
    # uncomment the below to have the first MUX created tossed
    # into the background instead (man ssh -> "-O ctl_cmd")
    # ControlPersist 10h

Host cbast.hkg1.corp.rackspace.net
    ForwardAgent yes
    ForwardX11Trusted yes
    ProxyCommand none
    User $SSO
    ControlMaster auto
    ControlPath ~/.ssh/master-%r@%h:%p
    TCPKeepAlive yes
    ServerAliveInterval 300
    #
    # Most techs run a terminal permanently open to the bastion
    # which serves as the MUX socket; if you do not do this,
    # uncomment the below to have the first MUX created tossed
    # into the background instead (man ssh -> "-O ctl_cmd")
    # ControlPersist 10h

Host cbast.iad3.corp.rackspace.net
    ForwardAgent yes
    ForwardX11Trusted yes
    ProxyCommand none
    User $SSO
    ControlMaster auto
    ControlPath ~/.ssh/master-%r@%h:%p
    TCPKeepAlive yes
    ServerAliveInterval 300
    #
    # Most techs run a terminal permanently open to the bastion
    # which serves as the MUX socket; if you do not do this,
    # uncomment the below to have the first MUX created tossed
    # into the background instead (man ssh -> "-O ctl_cmd")
    # ControlPersist 10h

Host cbast.ord1.corp.rackspace.net
    ForwardAgent yes
    ForwardX11Trusted yes
    ProxyCommand none
    User $SSO
    ControlMaster auto
    ControlPath ~/.ssh/master-%r@%h:%p
    TCPKeepAlive yes
    ServerAliveInterval 300
    #
    # Most techs run a terminal permanently open to the bastion
    # which serves as the MUX socket; if you do not do this,
    # uncomment the below to have the first MUX created tossed
    # into the background instead (man ssh -> "-O ctl_cmd")
    # ControlPersist 10h

Host cbast.syd2.corp.rackspace.net
    ForwardAgent yes
    ForwardX11Trusted yes
    ProxyCommand none
    User $SSO
    ControlMaster auto
    ControlPath ~/.ssh/master-%r@%h:%p
    TCPKeepAlive yes
    ServerAliveInterval 300
    #
    # Most techs run a terminal permanently open to the bastion
    # which serves as the MUX socket; if you do not do this,
    # uncomment the below to have the first MUX created tossed
    # into the background instead (man ssh -> "-O ctl_cmd")
    # ControlPersist 10h
" >> ~/.ssh/config
DIR=$(pwd)
echo "alias bastion=$DIR/bastionlogin.sh" >> ~/.bashrc
source ~/.bashrc
