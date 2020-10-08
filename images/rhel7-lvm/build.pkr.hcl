build {
  name = "redhat7lvm-apache-conf"
  
  description = <<EOF
        This build creates redhat images:
        * Pending 
        For the following builers :
        * azure
      EOF

  sources = [
    "source.azure-arm.redhat7lvm"
  ]

  provisioner "ansible" {
    playbook_file = "../../ansible/basic-apache-playbook.yml"
  }
}
