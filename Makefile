PLUGIN_NAME := servecm

.PHONY: install
install:
	helm plugin install $(shell pwd)

.PHONY: remove
remove:
	helm plugin remove $(PLUGIN_NAME)

.PHONY: remove-chartmuseum
remove-chartmuseum:
	rm -f $(shell which chartmuseum)
