This project has been created as part of the 42 curriculum by jjaroens.

Inception
Description

Inception is a System Administration project aims to broden knowledge of system administration by introducing containerization with Docker. The goal is to build a small-scale, secure infrastructure running multiple services using dedicated Docker containers.

The stack consists of:
- Nginx: Serving as the sole entry point via port 443 with TLSLv 1.2 or TSLv1.3.
- WordPress: Application server powered by php-fpm.
- MariaDb: Relational database storing WordPress data

Project Description

The project utilize Docker to encapsulate each service into its own isoloated environment. Every container is built from a Dockerfile based on the debian base image.

The serives run within a custom Docker network, isolating internal communications so that only Nginx exposes a port (443) to the host machine

Key Design Choices
- Debian Based Images: chosen for minimal footprint and precise control over installed dependencies
- Separate Services per Container: Nginx, WordPress, and MariaDB run in independent containers.
- PHP-FPM: configured to process dynamic requests for WordPress, decoupled from the web server.

Technical Comparisons
Virtual Machines vs Docker: Vms visualize entire hardware stacks, running full guest operating systems on top of a hypervisor. This results in heavy resource overhead and slow startup times. Docker uses OS-level visualization, sharing the host OS kernel and isolating processes, making containers lightweight and fast.

Secrets vs Environmental Variables: Environmental variables are stored in plain text in container runtime environments and can be exposed via docker inspect or process listings. Secrets provide encrypted or restricted access to sensitive data (passwrods, certificates), avoiding leakages in logs or version control.

Docker Network vs. Host Network: Docker Network creates isolated networks with custom DNS resolution between containers, keeping internal traffic off host interfaces. Host Network shares the host's network namespace directly, removing network isolation and exposing all container ports directly on the host machine.


Docker Volumes vs. Bind Mounts: Docker Volumes are managed directly by Docker within storage areas on the host system (/var/lib/docker/volumes), offering better performance, backup capabilities, and cross-platform portability. 
Bind Mounts link a specific host directory directly into a container, data live outside the environment.




