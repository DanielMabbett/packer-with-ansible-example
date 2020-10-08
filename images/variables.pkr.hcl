variable "subscription_id" {
  default = ""
}

variable "client_id" {
  default = ""
}

variable "client_secret" {  
  default = ""
}

variable "tenant_id" {  
  default = ""
}

variable "build_resource_group_name" {  
  default = "rg-build-resourcegroup"
}

variable "managed_image_resource_group_name" {  
  default = "rg-managedimage"
}

variable "managed_image_name" {  
  default = "mymanagedimagename"
}

variable "vm_size" {  
  default = "Standard_D2_v2"
}

variable "shared_image_gallery_resource_group" {  
  default = ""
}

variable "shared_image_gallery_gallery_name" {  
  default = ""
}

variable "shared_image_gallery_image_name" {  
  default = ""
}

variable "shared_image_gallery_image_version" {  
  default = ""
}

variable "shared_image_gallery_replication_regions" {  
  default = ["north europe"]
}

# locals {
#   debian_ami_name = "${var.image_id}-debian"
#   foo             = "bar"
# }