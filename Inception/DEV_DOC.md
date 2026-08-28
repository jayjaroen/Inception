# DEV_DOC.md
## 1. Purpose

This document is for developers and evaluators who need to understand, rebuild, inspect and maintain the Inception project.

The project is built inside a Virtual Machine and uses Docker Compose to orchestrate separate NGINX, WordPress/PHP-FPM and MariaDB containers.

## 2. Prerequisites

Install or prepare:

- Virtual Machine environment.
- Linux guest OS suitable for the project.
- Docker Engine.
- Docker Compose plugin.
- Git.
- Local hostname configuration for `<login>.42.fr`.

The Inception subject requires the project to be performed inside a VM.

## 3. Repository structure

```text
.
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
├── secrets/
└── srcs/
    ├── docker-compose.yml
    ├── .env
    └── requirements/
        ├── mariadb/
        ├── nginx/
        ├── wordpress/
```

Each mandatory service has its own Dockerfile.

## 4. Dockerfile responsibilities

### NGINX Dockerfile

The NGINX image:

- start from the pDebian base version;
- install NGINX and required dependencies;
- install/configure TLS;
- copy the NGINX configuration;
- run NGINX as the container's main process.

### WordPress Dockerfile

The WordPress image:

- start from the Debian base version;
- install PHP and PHP-FPM plus required extensions/tools;
- install/configure WordPress;
- run PHP-FPM as the main service process.

NGINX must not be installed in this container.

### MariaDB Dockerfile

The MariaDB image:

- start from the Debian base version;
- install MariaDB;
- configure the database;
- initialise the database/user configuration;
- use the persistent database volume;
- run MariaDB as the main process.

NGINX must not be installed in this container.

## 5. Compose configuration

`srcs/docker-compose.yml` should define:

- the three mandatory services;
- a Docker network;
- two named volumes;
- build instructions for each Dockerfile;
- environment variables;
- restart policies;
- the required NGINX port exposure.

The subject requires each Docker image to have the same name as its corresponding service and each service to run in a dedicated container.

## 6. Building

From the project root:

```bash
make
```

Or directly through Compose:

```bash
docker compose -f srcs/docker-compose.yml build
docker compose -f srcs/docker-compose.yml up -d
```

Validate the Compose configuration first:

```bash
docker compose -f srcs/docker-compose.yml config
```

## 7. Useful development commands

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
docker exec <container> <command>
```

Use the shell available in the chosen base image; a minimal Alpine image may not include Bash.

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


