# Description
This repository contains Vagrantfile and other files required for setting up a development/PoC environment. For now, it uses QEMU/KVM via libvirt as a backend.

# Usage
As it's almost always the case with Vagrant, it takes only a couple of commands to get things running:
1. `vagrant box add centos7-libvirt <box location>`
2. `vagrant up`
These commands will spin up 5 VMs using the box built by [Packer](https://www.packer.io) using template from git@github.com:AlekseyUsov/packer.git .

# Security Notes
The box is provisioned with a pre-created public key that corresponds to the private key `files/vagrant`. You can (and should) replace it with your own and make sure you specify the corresponding private key in the Vagrantfile by setting **config.ssh.private_key_path**.
