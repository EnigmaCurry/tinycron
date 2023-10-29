NAME=tinycron
VERSION=$(shell cat VERSION)
BUILD=$(shell git rev-parse --short HEAD)

clean:
	rm -rf build/

.PHONY: build
build:
	mkdir -p build
	go install
	go build -ldflags "-s -X main.version=$(VERSION) -X main.build=$(BUILD)" -o build/$(NAME)
	upx -9 build/$(NAME)

