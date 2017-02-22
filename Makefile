REPO=choffmeister/airfocus-ci

build:
	docker build -t $(REPO):server server/
	docker build -t $(REPO):web web/

deploy: build
	docker push $(REPO):server
	docker push $(REPO):web
