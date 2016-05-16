NAME=tinycron
VERSION=$(shell cat VERSION)
BUILD=$(shell git rev-parse --short HEAD)

build:
	mkdir -p build
	go get -v -d
	GOOS=darwin GOARCH=amd64 go build -ldflags "-s -X main.version=$(VERSION) -X main.build=$(BUILD)" -o build/$(NAME)-$(VERSION)-darwin-amd64
	GOOS=linux GOARCH=amd64 go build -ldflags "-s -X main.version=$(VERSION) -X main.build=$(BUILD)" -o build/$(NAME)-$(VERSION)-linux-amd64

release:
	rm -rf release && mkdir release
	go get github.com/progrium/gh-release/...
	cp build/* release
	gh-release create bcicen/$(NAME) $(VERSION) \
		$(shell git rev-parse --abbrev-ref HEAD) $(VERSION)

.PHONY: release
