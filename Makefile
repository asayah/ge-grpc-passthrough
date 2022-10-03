.PHONY: docker-local server
all: clean server docker-local docker-push


server:
	@CGO_ENABLED=0 GOOS=linux go build -a --ldflags '-extldflags "-static"' \
		-tags "netgo" -installsuffix netgo \
		-o server

docker-local: server
	docker build -t asayah/passthrough-grpc-service-example . --no-cache

docker-push:
	docker push asayah/passthrough-grpc-service-example

clean:
	@rm -fr server
