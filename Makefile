.DEFAULT_GOAL := help

.PHONY: help docs \
	hadoop-build hadoop-format hadoop-hdfs-up hadoop-yarn-up \
	hadoop-status hadoop-logs hadoop-smoke-hdfs hadoop-smoke-yarn \
	hadoop-drill-datanode hadoop-drill-nodemanager \
	hadoop-down hadoop-destroy

HADOOP_LAB := hadoop/setups/01_docker_compose_cluster
HADOOP_COMPOSE := docker compose --project-directory $(HADOOP_LAB) --file $(HADOOP_LAB)/compose.yaml

help: ## Show available commands
	@awk 'BEGIN {FS = ":.*## "; printf "Available commands:\n"} /^[a-zA-Z0-9_-]+:.*## / {printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

docs: ## List project documentation
	@find . -type f -name '*.md' -not -path './.git/*' | sort

hadoop-build: ## Build the pinned Hadoop image
	@$(HADOOP_COMPOSE) build namenode

hadoop-format: ## Initialize NameNode metadata if it does not exist
	@$(HADOOP_LAB)/scripts/format-namenode.sh

hadoop-hdfs-up: ## Start NameNode and three DataNodes
	@$(HADOOP_COMPOSE) up --detach --wait --no-build namenode datanode-1 datanode-2 datanode-3

hadoop-yarn-up: ## Start HDFS, YARN, and JobHistory Server
	@$(HADOOP_COMPOSE) --profile yarn up --detach --wait --no-build

hadoop-status: ## Show all Hadoop lab containers
	@$(HADOOP_COMPOSE) --profile yarn --profile tools ps --all

hadoop-logs: ## Follow Hadoop logs; optionally set SERVICE=name
	@$(HADOOP_COMPOSE) --profile yarn logs --follow --tail 200 $(SERVICE)

hadoop-smoke-hdfs: ## Verify HDFS storage and three-replica placement
	@$(HADOOP_LAB)/scripts/smoke-hdfs.sh

hadoop-smoke-yarn: ## Run and verify MapReduce WordCount on YARN
	@$(HADOOP_LAB)/scripts/smoke-yarn.sh

hadoop-drill-datanode: ## Stop, inspect, and recover one DataNode
	@$(HADOOP_LAB)/scripts/drill-datanode-loss.sh

hadoop-drill-nodemanager: ## Stop, inspect, and recover one NodeManager
	@$(HADOOP_LAB)/scripts/drill-nodemanager-loss.sh

hadoop-down: ## Stop Hadoop containers while preserving data
	@$(HADOOP_COMPOSE) --profile yarn --profile tools down --remove-orphans

hadoop-destroy: ## Delete Hadoop containers and volumes; requires CONFIRM
	@CONFIRM="$(CONFIRM)" $(HADOOP_LAB)/scripts/destroy.sh
