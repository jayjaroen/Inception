
This project has been created as part of the **42 curriculum** by **jjaroens**.

# Inception

## Description

**Inception** is a System Administration project that aims to broaden knowledge of system administration by introducing **containerization with Docker**.

The goal is to build a small-scale, secure infrastructure running multiple services using dedicated Docker containers.

The stack consists of:

- **Nginx**: Serving as the sole entry point via port `443` with **TLSv1.2 or TLSv1.3**.
- **WordPress**: Application server powered by **PHP-FPM**.
- **MariaDB**: Relational database storing WordPress data.

---

## Project Description

The project utilizes **Docker** to encapsulate each service into its own isolated environment.

Every container is built from a **Dockerfile** based on the **Debian** base image.

The services run within a **custom Docker network**, isolating internal communications so that only Nginx exposes a port (`443`) to the host machine.

---

## Key Design Choices

- **Debian-Based Images**: Chosen for their minimal footprint and precise control over installed dependencies.
- **Separate Services per Container**: Nginx, WordPress, and MariaDB run in independent containers.
- **PHP-FPM**: Configured to process dynamic requests for WordPress, decoupled from the web server.

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
## Use of AI

AI tools were used as a learning and debugging assistant throughout the project:

- **Understanding concepts**: Used AI to better understand Docker, containerization, networking, volumes, Nginx, PHP-FPM, MariaDB, and other system administration concepts.
- **Debugging and bug finding**: Used AI to analyze error messages, logs, and configuration files to identify potential bugs and suggest possible solutions.



