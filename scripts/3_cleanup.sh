#!/bin/sh

# cleanup
az group delete -n "rg-packer-test-001" --no-wait
az group delete -n "rg-packer-ephermeral-test-001" --no-wait