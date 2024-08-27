.PHONY: default
default: build

.PHONY: build
build:
	docker build . -t drawio:latest

.PHONY: xeyes
xeyes:
	docker run -it --rm -e DISPLAY -v $(XAUTHORITY):/root/.Xauthority -v /tmp/.X11-unix:/tmp/.X11-unix drawio:latest xeyes

.PHONY: test
test:
	docker run -it --rm -e DISPLAY -v $(XAUTHORITY):/root/.Xauthority -v /tmp/.X11-unix:/tmp/.X11-unix -v $(PWD):/drawio/diagrams drawio:latest /drawio/gen.sh /drawio/diagrams/test.drawio
