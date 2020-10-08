# .EXPORT_ALL_VARIABLES:
#   TF_SCHEMA_PANIC_ON_ERROR=1
#   GO111MODULE=on
#   GOFLAGS=-mod=vendor

default: build

tools:
	@echo "==> installing required tooling..."
	./scripts/install_tools.sh

validate:
	@echo "==> Validating packer files..."
	./scripts/0_validate.sh

depensure:
	@echo "==> Dependency Ensure..."
	./scripts/1_dep_ensure.sh

build:
	@echo "==> Packer Build..."
	./scripts/2_packer.sh

# To Add Docker!
# docker:
# 	@echo "==> Packer Build..."
# 	./scripts/2_packer.sh



# website-lint:
# 	@echo "==> Checking documentation spelling..."
# 	@misspell -error -source=text -i hdinsight,exportfs website/
# 	@echo "==> Checking documentation for errors..."
# 	@tfproviderdocs check -provider-name=azurerm -require-resource-subcategory \
# 		-allowed-resource-subcategories-file website/allowed-subcategories
# 	@sh -c "'$(CURDIR)/scripts/terrafmt-website.sh'"
# 
# website:
# ifeq (,$(wildcard $(GOPATH)/src/$(WEBSITE_REPO)))
# 	echo "$(WEBSITE_REPO) not found in your GOPATH (necessary for layouts and assets), get-ting..."
# 	git clone https://$(WEBSITE_REPO) $(GOPATH)/src/$(WEBSITE_REPO)
# endif
# 	@$(MAKE) -C $(GOPATH)/src/$(WEBSITE_REPO) website-provider PROVIDER_PATH=$(shell pwd) PROVIDER_NAME=$(PKG_NAME)
# 
# scaffold-website:
# 	./scripts/scaffold-website.sh
# 
# website-test:
# ifeq (,$(wildcard $(GOPATH)/src/$(WEBSITE_REPO)))
# 	echo "$(WEBSITE_REPO) not found in your GOPATH (necessary for layouts and assets), get-ting..."
# 	git clone https://$(WEBSITE_REPO) $(GOPATH)/src/$(WEBSITE_REPO)
# endif
# 	@$(MAKE) -C $(GOPATH)/src/$(WEBSITE_REPO) website-provider-test PROVIDER_PATH=$(shell pwd) PROVIDER_NAME=$(PKG_NAME)

.PHONY: tools depensure build validate
