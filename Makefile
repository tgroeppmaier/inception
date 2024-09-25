SHELL := /bin/bash

WORDPRESS_DATA_PATH := /home/${USER}/data/wordpress
MYSQL_DATA_PATH := /home/${USER}/data/mysql

all: build up

build: create_dirs
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
	sudo rm -rf $(WORDPRESS_DATA_PATH)
	sudo rm -rf $(MYSQL_DATA_PATH)

create_dirs:
	mkdir -p $(WORDPRESS_DATA_PATH)
	mkdir -p $(MYSQL_DATA_PATH)

copy_env:
	cp ../.env ./srcs/

re: clean all

.PHONY: all build up down clean re

