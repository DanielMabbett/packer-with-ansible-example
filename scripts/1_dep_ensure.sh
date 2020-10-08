#!/bin/sh

# Set az cli account 
az account set -s a9855100-b823-47c0-b28d-f76aba892c54
az account show -o table

# Get Sensitive Vars
ARM_SUBSCRIPTION_ID=`az keyvault secret show --vault-name kvdev123671  -n armsubscriptionid  | jq -r .value`
ARM_CLIENT_ID=`az keyvault secret show --vault-name kvdev123671  -n armclientid  | jq -r .value`
ARM_CLIENT_SECRET=`az keyvault secret show --vault-name kvdev123671  -n armclientsecret  | jq -r .value`
ARM_TENANT_ID=`az keyvault secret show --vault-name kvdev123671  -n armtenantid  | jq -r .value`

# Ensure Dependencies are built
az group create \
    -n "rg-packer-test-001" \
    -l "north europe"

az sig create \
    --gallery-name "sigdev001" \
    --resource-group "rg-packer-test-001"

az sig image-definition create \
    -g "rg-packer-dev-001" \
    --gallery-name "sigdev001" \
    --gallery-image-definition "MyImage" \
    --publisher "GreatPublisher" \
    --offer "GreatOffer" \
    --sku "GreatSku" \
    --os-type "linux"

az group create \
    -n "rg-packer-ephermeral-test-001" \
    -l "north europe"
