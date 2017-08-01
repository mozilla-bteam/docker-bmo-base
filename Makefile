

all:
	docker build -t mozillabteam/bmo-base:"$(shell git rev-parse --abbrev-ref HEAD)" .


.PHONY: all
