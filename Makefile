.DEFAULT_GOAL := help

.PHONY: help docs

help: ## Show available commands
	@awk 'BEGIN {FS = ":.*## "; printf "Available commands:\n"} /^[a-zA-Z0-9_-]+:.*## / {printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

docs: ## List project documentation
	@find docs -type f -name '*.md' | sort
