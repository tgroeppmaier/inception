all: build up

build:
	docker compose -f ./srcs/docker-compose.yml build

up:
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down

clean: down
	docker compose -f ./srcs/docker-compose.yml down --volumes --rmi all --remove-orphans
	docker volume prune -f
	docker network prune -f
	docker system prune -a -f --volumes
	sudo rm -rf /home/${USER}/data/wordpress/*
	sudo rm -rf /home/${USER}/data/mysql/*

re: clean all

.PHONY: all build up down clean re

