# User Documentation

## 1. Purpose

This project provides a small web infrastructure running three main services:

- **Nginx** - Web server and HTTPS entry point.
- **WordPress** - Content Management System (CMS) used to manage the website.
- **MariaDB** - Database used by WordPress to store website information.

The services run in separate Docker containers and communicate through a private Docker network.

The user only needs to access Nginx. WordPress and MariaDB are internal services and are not directly accessible from the host machine.

## 2. Starting and Stopping the project

From the project root:

```bash
make
```

Stopping the project:
```bash
make down
```

## 3. Access the website and the administration panel

The required domain is:
```text
https://jjaroens.42.fr
```
The administration interface is normally:
```text
https://jjaroens.42.fr/wp-admin/
```
 **Security Notice:** When accessing the site for the first time, your browser may display a **Privacy Warning** because the site uses a self-signed SSL certificate. This is expected for this project and does not indicate a configuration error.
 To continue, click **"Advanced"** and then select **"Proceed to jjaroens.42.fr (unsafe)"**.


## 4. Locating and Managing Credentials
**Environment Configuration:** Found inside the srcs/.env file. This contains non-sensitive deployment configurations (e.g., database names, domain keys).
**Sensitive Passwords (Secrets):** Managed inside the secrets/ directory at the root level:
secrets/db_password.txt - Stores the raw application user database password.
secrets/db_root_password.txt - Stores the administrative root database password.
secrets/wp_admin_password.txt - Stores the WordPress admin password.
secrets/wp_user_password.txt - Stores the WordPress user password.

## 5. Checking the service status

### Containers

```bash
docker compose ps
```

### Logs

```bash
docker compose -f srcs/docker-compose.yml logs
docker compose -f srcs/docker-compose.yml logs nginx
docker compose -f srcs/docker-compose.yml logs wordpress
docker compose -f srcs/docker-compose.yml logs mariadb
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

