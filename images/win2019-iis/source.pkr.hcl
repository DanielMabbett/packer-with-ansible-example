source "azure-arm" "win2019" {

    # Service Principal Details
    subscription_id           = var.subscription_id
    client_id                 = var.client_id
    client_secret             = var.client_secret
    tenant_id                 = var.tenant_id

    # Managed Image Details
    managed_image_resource_group_name = var.managed_image_resource_group_name
    managed_image_name                = var.managed_image_name

    # OS Details
    os_type         = "Linux"
    image_publisher = "RedHat" 
    image_offer     = "RHEL" 
    image_sku       = "7-LVM"
    image_version   = "latest"

    # Build Resource Group Details
    build_resource_group_name = var.build_resource_group_name

    # Connection Details
    communicator   =  "winrm"

    # VM Details
    vm_size = var.vm_size

    # Shared Image Gallery Details
    #shared_image_gallery_destination {
    #    resource_group      = var.shared_image_gallery_resource_group
    #    gallery_name        = var.shared_image_gallery_gallery_name
    #    image_name          = var.shared_image_gallery_image_name
    #    image_version       = var.shared_image_gallery_image_version
    #    replication_regions = var.shared_image_gallery_replication_regions
    #}
}
