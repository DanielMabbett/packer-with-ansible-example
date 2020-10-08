build {
  name = "win2019-iis"
  
  description = <<EOF
        This build creates Windows images:
        * Windows 2019 - IIS 
        For the following builers :
        * azure
      EOF

  sources = [
    "source.azure-arm.win2019"
  ]

  provisioner "ansible" {
    playbook_file = "../../ansible/basic-apache-playbook.yml"
  }
}
