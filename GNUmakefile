# .EXPORT_ALL_VARIABLES:
#   TF_SCHEMA_PANIC_ON_ERROR=1
#   GO111MODULE=on
#   GOFLAGS=-mod=vendor

default: build

# tools:
# 	@echo "==> installing required tooling..."
# 	@sh "$(CURDIR)/scripts/gogetcookie.sh"
# 	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $$GOPATH/bin v1.24.0

depensure:
	@echo "==> Dependency Ensure..."
	./scripts/1_dep_ensure.sh

build:
	@echo "==> Packer Build..."
	./scripts/2_packer.sh

# To Add Docker!

validate:
	@echo "==> Validate..."
	./scripts/2_packer.sh

fmtcheck:
	@sh "$(CURDIR)/scripts/gofmtcheck.sh"
	@sh "$(CURDIR)/scripts/timeouts.sh"
	@sh "$(CURDIR)/scripts/check-test-package.sh"

terrafmt:
	@echo "==> Fixing acceptance test terraform blocks code with terrafmt..."
	@find azurerm | egrep "_test.go" | sort | while read f; do terrafmt fmt -f $$f; done
	@echo "==> Fixing website terraform blocks code with terrafmt..."
	@find . | egrep html.markdown | sort | while read f; do terrafmt fmt $$f; done

generate:
	go generate ./azurerm/internal/provider/

goimports:
	@echo "==> Fixing imports code with goimports..."
	goimports -w $(PKG_NAME)/


lintunused:
	@echo "==> Checking source code against static check linters..."
	(while true; do sleep 300; echo "(I'm still alive and linting!)"; done) & PID=$$!; echo $$PID; \
	golangci-lint run ./... -v --no-config --concurrency 1 --deadline=30m10s --disable-all --enable=unused; ES=$$?; kill -9 $$PID; exit $$ES

lintrest:
	./scripts/run-lint-rest.sh


tflint:
	./scripts/run-tflint.sh

whitespace:
	@echo "==> Fixing source code with whitespace linter..."
	golangci-lint run ./... --no-config --disable-all --enable=whitespace --fix

test-docker:
	docker run --rm -v $$(pwd):/go/src/github.com/terraform-providers/terraform-provider-azurerm -w /go/src/github.com/terraform-providers/terraform-provider-azurerm golang:1.13 make test

test: fmtcheck
	@TEST=$(TEST) ./scripts/run-gradually-deprecated.sh
	@TEST=$(TEST) ./scripts/run-test.sh

test-compile:
	@if [ "$(TEST)" = "./..." ]; then \
		echo "ERROR: Set TEST to a specific package. For example,"; \
		echo "  make test-compile TEST=./$(PKG_NAME)"; \
		exit 1; \
	fi
	go test -c $(TEST) $(TESTARGS)

testacc: fmtcheck
	TF_ACC=1 go test $(TEST) -v $(TESTARGS) -timeout $(TESTTIMEOUT) -ldflags="-X=github.com/terraform-providers/terraform-provider-azurerm/version.ProviderVersion=acc"

acctests: fmtcheck
	TF_ACC=1 go test -v ./azurerm/internal/services/$(SERVICE)/tests/ $(TESTARGS) -timeout $(TESTTIMEOUT) -ldflags="-X=github.com/terraform-providers/terraform-provider-azurerm/version.ProviderVersion=acc"

debugacc: fmtcheck
	TF_ACC=1 dlv test $(TEST) --headless --listen=:2345 --api-version=2 -- -test.v $(TESTARGS)

website-lint:
	@echo "==> Checking documentation spelling..."
	@misspell -error -source=text -i hdinsight,exportfs website/
	@echo "==> Checking documentation for errors..."
	@tfproviderdocs check -provider-name=azurerm -require-resource-subcategory \
		-allowed-resource-subcategories-file website/allowed-subcategories
	@sh -c "'$(CURDIR)/scripts/terrafmt-website.sh'"

website:
ifeq (,$(wildcard $(GOPATH)/src/$(WEBSITE_REPO)))
	echo "$(WEBSITE_REPO) not found in your GOPATH (necessary for layouts and assets), get-ting..."
	git clone https://$(WEBSITE_REPO) $(GOPATH)/src/$(WEBSITE_REPO)
endif
	@$(MAKE) -C $(GOPATH)/src/$(WEBSITE_REPO) website-provider PROVIDER_PATH=$(shell pwd) PROVIDER_NAME=$(PKG_NAME)

scaffold-website:
	./scripts/scaffold-website.sh

website-test:
ifeq (,$(wildcard $(GOPATH)/src/$(WEBSITE_REPO)))
	echo "$(WEBSITE_REPO) not found in your GOPATH (necessary for layouts and assets), get-ting..."
	git clone https://$(WEBSITE_REPO) $(GOPATH)/src/$(WEBSITE_REPO)
endif
	@$(MAKE) -C $(GOPATH)/src/$(WEBSITE_REPO) website-provider-test PROVIDER_PATH=$(shell pwd) PROVIDER_NAME=$(PKG_NAME)

.PHONY: build build-docker test test-docker testacc vet fmt fmtcheck errcheck scaffold-website test-compile website website-test
