OWNER   = mozillabteam
NAME    = bmo-base
VERSION = 20160804.01
REPO    = $(OWNER)/$(NAME):$(VERSION)

build: Dockerfile 
	docker build -t $(REPO) .

upload:
	docker push $(REPO)


.PHONY: build upload


