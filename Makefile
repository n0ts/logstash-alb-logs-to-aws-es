.DEFAULT_GOAL := help

.EXPORT_ALL_VARIABLES:

TAG ?= 6.4.2

AWS_DEFAULT_REGION ?= ap-northeast-1
ifndef ($(AWS_ACCESS_KEY_ID),)
	AWS_ACCESS_KEY_ID ?= $(shell aws configure get aws_access_key_id --profile $(AWS_PROFILE))
	AWS_SECRET_ACCESS_KEY ?= $(shell aws configure get aws_secret_access_key --profile $(AWS_PROFILE))
endif
#ifndef ($(AWS_PROFILE,)
#	ES_HOST ?= $(shell aws --output text --profile $(AWS_PROFILE) --region $(AWS_DEFAULT_REGION) es describe-elasticsearch-domains --domain-names test-nakazawa --query 'DomainStatusList[0].Endpoint')
#endif
ifndef ($(ES_HOST,)
	ES_HOST ?= http://elasticsearch:9200
endif

LB_DNS_MNAME ?= localhost

.PHONY: up
up: # Up container
	@docker-compose up

.PHONY: up-local
up-local: # Up local container
	@docker-compose -f docker-compose-local.yml up

.PHONY: down
down: # Down container
	@docker-compose down

.PHONY: clean
clean: # Clean
	@rm -vfr elasticsearch/{data,logs}
	@rm -vfr logstash/{data,logs}
	@rm -vfr kibana/{data,logs}

.PHONY: help
help: # Show usage
	@echo 'Available targets are:'
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?# "}; {printf "  \033[36m%-8s\033[0m %s\n", $$1, $$2}'
