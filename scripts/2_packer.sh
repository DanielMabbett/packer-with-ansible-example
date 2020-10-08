#!/bin/sh

# Set az cli account 
az account set -s a9855100-b823-47c0-b28d-f76aba892c54
az account show -o table

# Validation
packer validate .

# Get Sensitive Vars
ARM_SUBSCRIPTION_ID=`az keyvault secret show --vault-name kvdev123671  -n armsubscriptionid  | jq -r .value`
ARM_CLIENT_ID=`az keyvault secret show --vault-name kvdev123671  -n armclientid  | jq -r .value`
ARM_CLIENT_SECRET=`az keyvault secret show --vault-name kvdev123671  -n armclientsecret  | jq -r .value`
ARM_TENANT_ID=`az keyvault secret show --vault-name kvdev123671  -n armtenantid  | jq -r .value`

# Build
packer build \
    -var subscription_id=$ARM_SUBSCRIPTION_ID \
    -var client_id=$ARM_CLIENT_ID \
    -var client_secret=$ARM_CLIENT_SECRET \
    -var tenant_id=$ARM_TENANT_ID \
    -var build_resource_group_name="rg-packer-ephermeral-test-001" \
    -var managed_image_resource_group_name="rg-packer-test-001" \
    -var managed_image_name="MyImage" \
    -var vm_size="Standard_D2_v2" \
    -var shared_image_gallery_resource_group="rg-packer-test-001" \
    -var shared_image_gallery_gallery_name="sigdev001" \
    -var shared_image_gallery_image_name="MyImage" \
    -var shared_image_gallery_image_version="0.1.0" \
    -force \
    .
