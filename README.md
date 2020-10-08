# packer-with-ansible-example

## Virtual Machine Images

Location: `./ansible`

* Redhat Enterprise 7-LVM
* Windows Server 2019 Datacenter

## Ansible Playbooks

Location: `./ansible`

## LEGACY: How it works

OLD
----

DOMAIN CONTROLLERS!

1 Terraform > Deploy
2 Scripts / Manual > Configuration Management

NEW
----

IIS MACHINES. LINUX.

1 Packer > Build a temporary vm
2 Packer + Ansible > Configuration Management
3 Terraform > Deploy the packer built images