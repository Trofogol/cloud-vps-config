# What it for

If you just created instance (VPS/VM) in cloud provider that does 
not create custom user account (you should connect as root), this 
repo's script can do this for you and install Docker and docker-compose

> created for Ubuntu OS, tested on Ubuntu 20.04

# What does it do

This repo's main script uses the other files to

- create custom user

- add it to sudo group and disable password prompt when you will use sudo

- copy your public ssh key to new user (you will be able to connect as that user)

- prohibit passwords usage when connecting via SSH

- install docker and docker-compose

- add user permissions to use docker (and docker-compose)

# How to use

1. Create your vpc using ssh key

1. make sure you can connect using that key

1. connect as root (`ssh root@your.vps.fqdn.or.ip.address`)

1. clone this repo

1. change working directory to this repo `cd time4vps-config`

1. run init install script (specify your own user): `./init_install.sh username`
