NAME = inception

-include srcs/.env

DATA_DIR = /home/$(USER_NAME)/data
WP_DATA  = $(DATA_DIR)/wordpress
DB_DATA  = $(DATA_DIR)/mariadb

all: up

up: build
	@echo "..Starting containers..."
	@docker compose -f srcs/docker-compose.yml up -d

build:
	@echo "Creating data directories if they don't exist"

	@if [ ! -d "$(DATA_DIR)" ]; then \
		mkdir -p $(DATA_DIR) && chmod 777 $(DATA_DIR); \
	fi

	@if [ ! -d "$(WP_DATA)" ]; then \
		mkdir -p $(WP_DATA) && chmod 777 $(WP_DATA); \
	fi

	@if [ ! -d "$(DB_DATA)" ]; then \
		mkdir -p $(DB_DATA) && chmod 777 $(DB_DATA); \
	fi

down:
	@echo "Stopping containers..."
	@docker compose -f srcs/docker-compose.yml down

clean:
	@echo "Removing containers, networks, and volumes..."
	@docker compose -f srcs/docker-compose.yml down -v --rmi all --remove-orphans

fclean: clean
	@echo "Cleaning up data directories..."
	@docker run --rm -v $(DATA_DIR):/data debian:bookworm rm -rf /data/wordpress /data/mariadb
	@docker system prune -f -a --volumes

re: fclean all

.PHONY: all up build down clean fclean re


# DATA_DIR = /home/jjaroens/data
# WP_DATA = $(DATA_DIR)/wordpress
# DB_DATA = $(DATA_DIR)/mariadb

# all: up
# up: build
# 	@echo "..Starting containers..."
# 	@docker compose -f srcs/docker-compose.yml up -d

# build:
# 	@echo "Creating data directories if they don't exist"

# 	@if [ ! -d "$(DATA_DIR)" ]; then \
# 		mkdir -p $(DATA_DIR) && chmod 777 $(DATA_DIR); \
# 	fi

# 	@if [ ! -d "$(WP_DATA)" ]; then \
# 		mkdir -p $(WP_DATA) && chmod 777 $(WP_DATA); \
# 	fi

# 	@if [ ! -d "$(DB_DATA)" ]; then \
# 		mkdir -p $(DB_DATA) && chmod 777 $(DB_DATA); \
# 	fi

# down:
# 	@echo "Stopping containers..."
# 	@docker compose -f srcs/docker-compose.yml down

# clean:
# 	@echo "Removing containers, networks, and volumes..."
# 	@docker compose -f srcs/docker-compose.yml down -v --rmi all --remove-orphans

# fclean: clean
# 	@echo "Cleaning up data directories.."
# 	@docker run --rm -v $(DATA_DIR):/data debian:bookworm rm -rf /data/mariadb/data/wordpress
# 	@rm -rf $(DATA_DIR)/wordpress$(DATA_DIR)/mariadb
# 	@rm -rf $(DATA_DIR)
# 	@docker system prune -f -a --volumes

# re: fclean all

# .PHONY: all up build down clean fclean re

