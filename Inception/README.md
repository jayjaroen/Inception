This project has been created as part of the **42 curriculum** by **jjaroens**.

# Description

**Inception** is a System Administration project that aims to broaden knowledge of system administration by introducing **containerization with Docker**.

The goal is to build a small-scale, secure infrastructure running multiple services using dedicated Docker containers.

The stack consists of:

- **Nginx**: Serving as the sole entry point via port `443` with **TLSv1.2 or TLSv1.3**.
- **WordPress**: Application server powered by **PHP-FPM**.
- **MariaDB**: Relational database storing WordPress data.

The project utilizes **Docker** to encapsulate each service into its own isolated environment.
Every container is built from a **Dockerfile** based on the **Debian** base image.
The services run within a **custom Docker network**, isolating internal communications so that only Nginx exposes a port (`443`) to the host machine.

---
## Key Design Choices
- **One Service per Container**: Nginx, WordPress, and MariaDB run in separate containers to provide isolation, clear responsibilities, and easier maintenance.
- **Debian-Based Images**: Debian is used as the base image to provide a familiar Linux environment and greater control over installed packages and dependencies.
- **Custom Docker Network**: A dedicated Docker network allows WordPress and MariaDB to communicate internally using Docker's DNS while keeping internal services isolated from the host.
- **Nginx as the Only Entry Point**: Only Nginx exposes port `443` to the host. WordPress and MariaDB remain accessible only through the internal Docker network, reducing the external attack surface.
- **PHP-FPM**: PHP-FPM is used to process WordPress PHP requests separately from Nginx, following the separation of web server and application processing.
- **Docker Volumes**: Volumes are used to persist WordPress and MariaDB data independently from the container lifecycle.
- **HTTPS with TLS**: Nginx is configured to use HTTPS with TLSv1.2/TLSv1.3 to encrypt communication between the client and the server.
- **Secrets for Sensitive Data**: Sensitive credentials such as database passwords are managed separately from regular configuration to reduce the risk of exposing them in the source code.

---
# Instructions

## Requirements
Before running the project, make sure the following software is installed:
- **Docker**
- **Docker Compose**
- **Make**

## Installation
**1. Clone the repository:**
```bash
git clone <repository_url>
cd inception
```
**2. Configure Environment variables & Secrets:** Make sure that .env file is located inside the srcs/ directory. The secrets/ folder is at the root directory containing the .txt file storing credentials.

**3. Build and Run:** From the project root directory:
```bash
make
```
The following services should be started:
```bash
Nginx
WordPress
MariaDB
```
Check the running containers with:
```bash
docker ps
```
**4. Local domain configuration:**
```bash
cd /etc/hosts
127.0.0.1 jjaroens.42.fr
```
**5. Accessing WordPress:**
```bash
https://jjaroens.42.fr
```
## Administrative && Useful Commands
To stop the running containers:
```bash
make down
```
Rebuilding the project:
```bash
make re
```
Removing containers and associated artifacts:
```bash
make clean
```
Removing containers, images, networks, and other generated resources:
```bash
make fclean
```
Check running containers:
```bash
docker ps
```
View logs:
```bash
docker compose logs <container_name>
```
Check Docker Volumes:
```bash
docker volume ls
```
Open a shell inside a running container:
```bash
docker exec -it <container_name> base
```

---
# Technical Comparisons

## Virtual Machines vs Docker

**Virtual Machines** virtualize entire hardware stacks, running full guest operating systems on top of a hypervisor. This results in higher resource overhead and slower startup times.

**Docker** uses OS-level virtualization, sharing the host OS kernel while isolating processes. This makes containers lightweight and fast to start.

| Virtual Machines | Docker Containers |
|---|---|
| Virtualize hardware | Use OS-level virtualization |
| Run a complete guest OS | Share the host OS kernel |
| Higher resource usage | Lower resource usage |
| Larger disk footprint | Smaller disk footprint |
| Slower startup | Faster startup |
| Managed by a hypervisor | Managed by Docker Engine |

---

## Secrets vs Environment Variables

**Environment variables** are commonly used to provide configuration values to containers. However, sensitive information stored as environment variables can potentially be exposed through mechanisms such as `docker inspect` or process listings.

**Secrets** provide a more secure mechanism for handling sensitive information such as passwords and certificates, reducing the risk of exposing credentials through configuration files, logs, or version control.

| Environment Variables | Secrets |
|---|---|
| Convenient for configuration | Designed for sensitive information |
| Can potentially be exposed at runtime | Provides more controlled access |
| Often visible through container configuration | Designed to reduce secret exposure |
| Suitable for non-sensitive configuration | Suitable for passwords, certificates, etc. |

---

## Docker Network vs Host Network

### Docker Network

A **Docker Network** creates an isolated network for containers and provides internal DNS resolution between services.
A **Host Network** shares the host machine's network namespace directly with the container.

| Docker Network | Host Network |
|---|---|
| Provides network isolation | Shares the host network namespace |
| Containers communicate through Docker networking | Containers use the host network directly |
| Provides Docker DNS/service discovery | No Docker network isolation |
| Ports must be explicitly published | Services can use host interfaces directly |
| Better suited for isolated services | Provides less network isolation |

---
## Docker Volumes vs Bind Mounts
**Docker volume** is storage that is managed by Docker.
**Bind Mount** maps a specific directory or file on the host directory into a container.

---
# Resources
## References
- [Docker Documentation](https://docs.docker.com/)
- [Nginx Documentation](https://nginx.org/en/docs/) 
- [PHP-FPM Documentation](https://www.php.net/manual/en/install.fpm.php) 
- [MariaDB Documentation](https://mariadb.com/docs/) 
- [WordPress Documentation](https://developer.wordpress.org/) 

## Use of AI

AI tools were used as a learning and debugging assistant throughout the project:

- **Understanding concepts**: Used AI to better understand Docker, containerization, networking, volumes, Nginx, PHP-FPM, MariaDB, and other system administration concepts.
- **Debugging and bug finding**: Used AI to analyze error messages, logs, and configuration files to identify potential bugs and suggest possible solutions.



