SHELL += -eu

REPO ?= osmorgan/fluentd-elasticsearch:latest

hello:
	@echo "hello"

build:
	docker build -t ${REPO} .

push: build
	docker push ${REPO}