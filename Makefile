IMAGE_URL ?= 248174752766.dkr.ecr.us-west-1.amazonaws.com/shorten

restart: .docker
	ssh -At vpn.cernu.us sudo systemctl restart shorten

docker: .docker

.docker: Dockerfile
	@ set -e; \
	eval "$$(aws ecr get-login --no-include-email)" && \
	docker buildx build --push --platform linux/amd64,linux/arm64/v8 -t ${IMAGE_URL} . && \
	touch .docker
