virssh - allow users to control their libvirt VM through SSH.

virssh is a simple wrapper around sudo and virsh that allows users to control
their libvirt VM(s) through SSH. Currently supported is starting/stopping VMs,
serial console and listing all VMs to get their status.

Configuration:

1. Create a user "vmadmin".

2. Give that user sudo permissions for calling virsh, so she may control (all)
   VMs:

    Defaults:vmadmin !requiretty
    vmadmin ALL = (root) NOPASSWD: /usr/bin/virsh

3. For every one of your users, create a line in vmadmin's .ssh/authorized_keys:

   command="/usr/local/bin/virssh myfancyuser",permitopen="localhost:5915",no-X11-forwarding,no-agent-forwarding ssh-rsa AAAAB...== myfancyuser@hjome

Usage:

  The user may now control her VM using the following commands:

    ssh -t vmadmin@vmserver sudo virsh list
    ssh -t vmadmin@vmserver sudo virsh console myfancyvm
    ssh -t vmadmin@vmserver sudo virsh destroy myfancyvm
    ssh -t vmadmin@vmserver sudo virsh shutdown myfancyvm
    ssh -t vmadmin@vmserver sudo virsh start myfancyvm
    ssh -t vmadmin@vmserver sudo virsh start myfancyvm --console

  If you use a "permitopen" directive, that user may also use the console to
  keep an SSH tunnel open to use VNC.
