# Developer Document
This document is for developers who need to understand, rebuild, inspect and maintain the Inception project.
The project is built inside a Virtual Machine and uses Docker Compose to orchestrate separate NGINX, WordPress/PHP-FPM and MariaDB containers.

# 1. Setting up the environment

## Prerequisites
Install or prepare:
- Virtual Machine environment.
- Linux guest OS suitable for the project.
- Docker Engine.
- Docker Compose plugin.
- Git.

## Environment Configuration
**Environment variables**

Project-specific configuration is stored in the .env file:
```bash
srcs/.env
```
**Secret variables**
Sensitive credentials are stored separately from normal configuration.
```bash
srcs/secrets/
├── db_password.txt
├── db_root_password.txt
└── wp_admin_password.txt
```

Sensitive passwords should not be hard-coded into Dockerfiles, the Compose file, or the source code.

## 2. Deployment Management

From the project root:

```bash
make
```
Or directly through Compose:

```bash
docker compose -f srcs/docker-compose.yml build
docker compose -f srcs/docker-compose.yml up -d
```
Tear down services & interconnections:
```bash
make clean
```

## 3. Useful development commands

### Container status
```bash
docker ps
docker ps -a
docker compose ps
```
### Images
```bash
docker images
docker image ls
docker image inspect <image>
docker image history <image>
```
### Logs
```bash
docker compose logs
docker compose logs -f nginx
docker compose logs -f wordpress
docker compose logs -f mariadb
```
### Execute a command
```bash
docker exec -it <container> sh
```
### Networks
```bash
docker network ls
docker network inspect <network>
```
### Volumes
```bash
docker volume ls
docker volume inspect <volume>
```
## 4. Data Storage and Persistence
Data is stored independently of the container lifecycles using Docker volumes mapped to local host directories.

**Host Machine Storage Paths:**

WordPress Files: /home/jjaroens/data/wordpress

MariaDB Database: /home/jjaroens/data/mariadb

**Persistence Logic:**

Running *make clean* removes the containers, but your physical data remains completely safe on the host machine. When you spin the environment back up using *make*, the containers automatically remount these folders to restore your previous state without any data loss. If you want to completely wipe the system and reset the data, run *make fclean*.
