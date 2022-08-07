PROJECT ?= kev-pinto-sandboox
LOCATION=europe-west2
STAGING_BUCKET ?= gs://hdm-demo-bucket-411092246126/staging
TEMP_BUCKET ?= gs://hdm-demo-bucket-411092246126/temp
BUILD_CONTAINER ?= flextest
BUILD_CONTAINER_TAG ?= latest

.PHONY: $(shell sed -n -e '/^$$/ { n ; /^[^ .\#][^ ]*:/ { s/:.*$$// ; p ; } ; }' $(MAKEFILE_LIST))

.DEFAULT_GOAL := help

help: ## This is help
	@echo ${MAKEFILE_LIST}
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build:
	docker build -t ${BUILD_CONTAINER}:${BUILD_CONTAINER_TAG} .

shell: build ## This will build the Airflow testing Container -- Run this once only
	docker run --rm --entrypoint /bin/bash -t ${BUILD_CONTAINER}:${BUILD_CONTAINER_TAG}


deploy: tests ## Deploy Dags to Your Project -- This Runs your Unit tests first
	@echo ${DAG_BUCKET}
	rm -rf dags/__pycache__
	gsutil -m rsync -r dags/  ${DAG_BUCKET}
