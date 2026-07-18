.DEFAULT_GOAL := help

.PHONY: help roadmap

help: ## Show available commands
	@awk 'BEGIN {FS = ":.*## "; printf "Available commands:\n"} /^[a-zA-Z0-9_-]+:.*## / {printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

roadmap: ## Print the implementation roadmap
	@cat docs/roadmap.md
