IMAGE_NAME = tidal-image
CONTAINER_NAME = tidal

help: ## Affiche cette aide
	@echo "Commandes disponibles :"
	@grep -E '^[a-zA-Z0-9_-]+:.*?##' Makefile \
	| awk 'BEGIN {FS=":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

build: ## Build l'image docker
	docker build -t $(IMAGE_NAME) .

build-c: ## Build sans cache
	docker build --no-cache -t $(IMAGE_NAME) .

run: ## Run en interactif
	docker run -it --name $(CONTAINER_NAME) --device /dev/snd --cap-add=sys_nice --ulimit rtprio=95 --ulimit memlock=-1 $(IMAGE_NAME) sh

once: build run clean ## build + run + clean

once-c: build-c run clean ## build-c + run + clean

show: ## Montre les images et dockers present
	docker image ls
	docker ps -a

clean: ## Supprime l'image et le docker
	docker rm -f $(CONTAINER_NAME) 2>/dev/null || true
	docker rmi $(IMAGE_NAME) 2>/dev/null || true

.PHONY: help build build-c run once once-c show clean
