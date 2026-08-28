# USER_DOC.md

## 1. Purpose

This document explains how to use and operate the Inception infrastructure after it has been installed.

The stack provides a WordPress website through NGINX, with PHP-FPM handling PHP execution and MariaDB storing the database.

## 2. Services

### NGINX

NGINX is the public entry point.

- Accepts HTTPS traffic on port 443.
- Handles TLS.
- Routes requests to the WordPress/PHP-FPM service.
- It is the only service that should be directly exposed to the outside.

### WordPress + PHP-FPM

This container runs WordPress and PHP-FPM.

- WordPress provides the website and administration interface.
- PHP-FPM executes PHP scripts.
- NGINX and PHP-FPM are separate services.

### MariaDB

MariaDB provides the database used by WordPress.

It should not be directly exposed to the host. WordPress communicates with it through the Docker network.

## 3. Starting the project

From the project root:

```bash
make
```

If the project Makefile provides explicit targets, use the corresponding documented target.

Check the result:

```bash
docker compose -f srcs/docker-compose.yml ps
```

## 4. Stopping the project

To stop and remove the containers/network created by Compose:

```bash
docker compose -f srcs/docker-compose.yml down
```

Stopping/removing containers does not necessarily remove named volumes. This is important because the volumes contain persistent data.

## 5. Accessing the website

The required domain is:

```text
https://<login>.42.fr
```

The site must be accessed over HTTPS through port 443.

If the domain does not resolve, verify that `<login>.42.fr` points to the VM's local IP address.

## 6. Accessing WordPress administration

The administration interface is normally:

```text
https://<login>.42.fr/wp-admin/
```

Use the administrator account configured for the project.

The administrator username must comply with the project requirement: it must not contain `admin` or `administrator` (case-insensitively).

## 7. Credentials

Credentials must not be stored in Dockerfiles or committed to Git.

Depending on the implementation, credentials may be supplied through:

- `.env` for non-secret configuration;
- Docker secrets for confidential values;
- local secret files under `secrets/`.

Typical secret categories include:

- WordPress database password;
- MariaDB root password;
- WordPress administrator credentials.

To inspect Docker secrets, if the project uses them:

```bash
docker secret ls
```

Do not print or paste secret contents into logs, Git, or public documentation.

## 8. Checking service health

### Containers

```bash
docker compose -f srcs/docker-compose.yml ps
docker ps
```

### Logs

```bash
docker compose -f srcs/docker-compose.yml logs
docker compose -f srcs/docker-compose.yml logs nginx
docker compose -f srcs/docker-compose.yml logs wordpress
docker compose -f srcs/docker-compose.yml logs mariadb
```

Follow logs live:

```bash
docker compose -f srcs/docker-compose.yml logs -f
```

### Networks

```bash
docker network ls
docker network inspect <network_name>
```

### Volumes

```bash
docker volume ls
docker volume inspect <volume_name>
```

