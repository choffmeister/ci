REPO=choffmeister/airfocus-ci
TAG=latest

build:
	docker build -t $(REPO):$(TAG) .

deploy: build
	docker push $(REPO):$(TAG)
