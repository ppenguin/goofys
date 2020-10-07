export CGO_ENABLED=0

GOOS ?= linux
GOARCH ?= amd64

run-test: s3proxy.jar
	./test/run-tests.sh


s3proxy.jar:
	wget https://github.com/gaul/s3proxy/releases/download/s3proxy-1.7.0/s3proxy -O s3proxy.jar


get-deps: s3proxy.jar
	go get -t ./...


.PHONY:
clean:
	rm -rf build && mkdir -p build


build: build/goofys_$(GOOS)_$(GOARCH)


build/goofys_%:
	go build -ldflags "-X main.Version=`git rev-parse HEAD`" -o $@


install:
	go install -ldflags "-X main.Version=`git rev-parse HEAD`"
