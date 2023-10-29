NAME=tinycron
VERSION=$(shell cat VERSION)
BUILD=$(shell git rev-parse --short HEAD)

clean:
	rm -rf build/

.PHONY: build
build:
	mkdir -p build
	go install
	GOOS=darwin GOARCH=amd64 go build -ldflags "-s -X main.version=$(VERSION) -X main.build=$(BUILD)" -o build/$(NAME)-$(VERSION)-darwin-amd64
	GOOS=linux GOARCH=amd64 go build -ldflags "-s -X main.version=$(VERSION) -X main.build=$(BUILD)" -o build/$(NAME)-$(VERSION)-linux-amd64
	GOOS=linux GOARCH=arm64 go build -ldflags "-s -X main.version=$(VERSION) -X main.build=$(BUILD)" -o build/$(NAME)-$(VERSION)-linux-arm64
	upx -9 build/$(NAME)-$(VERSION)-linux-amd64
	upx -9 build/$(NAME)-$(VERSION)-linux-arm64

release:
	rm -rf release && mkdir release
	go get github.com/progrium/gh-release/...
	cp build/* release
	gh-release create bcicen/$(NAME) $(VERSION) \
		$(shell git rev-parse --abbrev-ref HEAD) $(VERSION)

.PHONY: release
