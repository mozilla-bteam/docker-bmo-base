OWNER = mozillabteam
NAME  = bmo-base
REPO  = $(OWNER)/$(NAME):$(TAG)

ifndef TAG
TAG    := $(shell date +%Y%m%d)
endif

build: Dockerfile 
	docker build -t $(REPO) .
	docker build -t $(subst $(TAG),latest,$(REPO)) .

upload:
	docker push $(REPO)
	docker push $(subst $(TAG),latest,$(REPO))

.PHONY: build upload


