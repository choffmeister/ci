REPO=choffmeister/ci

build:
	cat Dockerfile.base Dockerfile.openjdk Dockerfile.node Dockerfile.custom > Dockerfile
	docker build -t $(REPO):latest .

push: build
	docker push $(REPO):latest
