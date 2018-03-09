# Description
This repository contains Vagrantfile and other files required for setting up a development/PoC environment. For now, it uses QEMU/KVM via libvirt as a backend.

# Usage
As it's almost always the case with Vagrant, it takes only a couple of commands to get things running:
1. `vagrant box add centos7-libvirt <box location>`
2. `vagrant up`
These commands will spin up 5 VMs using the box built by [Packer](https://www.packer.io) using template from git@github.com:AlekseyUsov/packer.git .

# Security Notes
The box is provisioned with a pre-created public key that corresponds to the private key `files/vagrant`. You can (and should) replace it with your own and make sure you specify the corresponding private key in the Vagrantfile by setting **config.ssh.private_key_path**.

# Environment Variables

The Vagrantfile exposes the following optional environment variables:

|Name               |Description                                                     |Default Value     |
|-------------------|----------------------------------------------------------------|------------------|
|VAGRANT_VM_COUNT   |Number of VMs to spin up                                        |1                 |
|VAGRANT_PROXY_HOST |Proxy address. Inserted into /etc/yum.conf and /etc/profile     |'' (Empty string) |
|VAGRANT_PROXY_PORT |Proxy port. Inserted into /etc/yum.conf and /etc/profile        |3128 (Squid)      |
|VAGRANT_VM_VCPUS   |Number of vcpus assigned to a VM                                |2                 |
|VAGRANT_VM_RAM     |Amount of RAM assigned to a VM                                  |4096              |
