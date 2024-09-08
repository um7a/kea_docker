IMAGE_NAME := um7a/kea
KEA_VERSION := 2.6
IMAGE_VERSION := 1
TAG := ${KEA_VERSION}.${IMAGE_VERSION}
CONTAINER_NAME := $(shell echo test_run_${IMAGE_NAME}_${TAG} | sed -e s/\\//_/g)
IMAGE_FILE_NAME := $(shell echo ${IMAGE_NAME}_${TAG}.tar | sed -e s/\\//_/g)

ContainerExists = "$(shell docker ps | grep ${CONTAINER_NAME})"

.PHONY: help
help:
	@echo ""
	@echo "  TARGETS"
	@echo "    build  ... Build docker image ${IMAGE_NAME}"
	@echo "    save   ... Save docker image ${IMAGE_NAME} to file"
	@echo "    clean  ... Clean docker image ${IMAGE_NAME}"
	@echo "    run    ... Run docker container using image ${IMAGE_NAME}"
	@echo "    attach ... Attach on docker container using image ${IMAGE_NAME}"
	@echo "    stop   ... Stop docker container which was created by run target"
	@echo "    logs   ... Show logs of docker container"
	@echo ""

.PHONY: build
build: Dockerfile
	docker build --rm -t ${IMAGE_NAME}:${TAG} .

.PHONY: save
save:
	docker save -o ${IMAGE_FILE_NAME} ${IMAGE_NAME}:${TAG}
	gzip ${IMAGE_FILE_NAME}

.PHONY: clean
clean: stop
	docker rmi ${IMAGE_NAME}:${TAG}
	rm -f ${IMAGE_FILE_NAME}.gz

.PHONY: run
run: stop
	@echo "Start test container."
	docker run \
	-itd \
	--rm \
	--net host \
	--mount type=bind,source=${PWD}/files/etc/kea,target=/etc/kea \
	--name ${CONTAINER_NAME} \
	${IMAGE_NAME}:${TAG}

.PHONY: attach
attach:
	# Execute bash
	docker exec \
	-it \
	${CONTAINER_NAME} \
	/bin/bash

.PHONY: stop
stop:
ifneq (${ContainerExists}, "")
	@echo "!!! Container exists. Delete. !!!"
	docker stop \
	${CONTAINER_NAME}
else
	@echo "Container does not exist."
endif

.PHONY: logs
logs:
	docker logs \
	-f \
	${CONTAINER_NAME}
