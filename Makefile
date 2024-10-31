DOCKERHUB_USERNAME=singha53
IMAGE_VERSION=v0.1
IMAGE_NAME=rnaseq

# build docker image
build:
	docker build -t $(DOCKERHUB_USERNAME)/$(IMAGE_NAME):$(IMAGE_VERSION) .

# run interactive docker image
run:
	docker run -it -v $(shell pwd):/home $(DOCKERHUB_USERNAME)/$(IMAGE_NAME):$(IMAGE_VERSION)

# push docker image to dockerhub
push:
	docker push $(DOCKERHUB_USERNAME)/$(IMAGE_NAME):$(IMAGE_VERSION)
