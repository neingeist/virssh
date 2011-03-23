virssh - allow users to control their libvirt VM through SSH.

virssh is a simple wrapper around sudo and virsh that allows users to control
their libvirt VM(s) through SSH. Currently supported is starting/stopping VMs,
serial console and listing all VMs to get their status. Authorization is done
using SSH public keys.

Configuration
=============

1. Create a user <code>vmadmin</code>.

2. Give that user sudo permissions for calling virsh, so she may control (all)
   VMs:

<pre><code>Defaults:vmadmin !requiretty
vmadmin ALL = (root) NOPASSWD: /usr/bin/virsh</code></pre>

3. For every one of your users, create a line in vmadmin's .ssh/authorized_keys
   using their SSH public keys:

<pre><code>command="/usr/local/bin/virssh myfancyvm",permitopen="localhost:5915",no-X11-forwarding,no-agent-forwarding ssh-rsa AAAAB...== myfancyuser@home</code></pre>

   Instead of specifying only one VM "myfancyvm", you may also specify multiple
   VMs by regex, for example "(myfancyvm|myothervm)".

Usage
=====

The user may now control her VM using the following commands:

    ssh -t vmadmin@vmserver sudo virsh list
    ssh -t vmadmin@vmserver sudo virsh console myfancyvm
    ssh -t vmadmin@vmserver sudo virsh destroy myfancyvm
    ssh -t vmadmin@vmserver sudo virsh shutdown myfancyvm
    ssh -t vmadmin@vmserver sudo virsh start myfancyvm
    ssh -t vmadmin@vmserver sudo virsh start myfancyvm --console

If you use a "permitopen" directive, that user may also use the console 
command to keep an SSH tunnel open to use VNC.
