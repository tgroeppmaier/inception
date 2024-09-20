# inception

## Project Goal

The goal of the Inception project is to:

1. Set up a small infrastructure using Docker containers
2. Create a virtual environment with multiple interconnected services:
   - NGINX web server (with TLS)
   - WordPress (with php-fpm)
   - MariaDB database
3. Implement proper data persistence using Docker volumes
4. Establish secure communication between containers using a Docker network
5. Automate the entire setup process using Docker Compose and Makefiles
6. Practice system administration and containerization skills

The project emphasizes:

- Building custom Docker images
- Configuring services securely
- Using environment variables and secrets management
- Following best practices for Dockerfile creation and container management

## Components

1. **Docker**: Docker is a tool designed to make it easier to create, deploy, and run applications by using containers. Containers allow a developer to package up an application with all of the parts it needs, such as libraries and other dependencies, and ship it all out as one package. Unlike virtual machines, Docker containers share the host system's kernel, making them more lightweight and efficient.

2. **Nginx Container**: Acts as a web server and reverse proxy.
3. **WordPress Container**: Runs WordPress and PHP-FPM to handle PHP requests.
4. **Database Container**: Runs MariaDB to store WordPress data.

## Workflow

1. **Client Request**: A user makes a request to the website by entering the URL in their browser.

2. **Nginx Receives Request**: The request first hits the Nginx container. Nginx listens on port 443 (HTTPS) for incoming requests.

3. **Nginx as Reverse Proxy**: Nginx acts as a reverse proxy, forwarding the request to the appropriate backend service. In this case, it forwards the request to the WordPress container.

4. **WordPress Container**: The WordPress container receives the forwarded request. This container runs PHP-FPM, which processes PHP scripts.

5. **PHP-FPM Processing**: PHP-FPM processes the PHP scripts that make up the WordPress application. It handles PHP requests separately from the web server, allowing for efficient handling of multiple requests concurrently.

6. **Database Interaction**: During the processing of the PHP scripts, WordPress may need to interact with the database to fetch or store data. The WordPress container communicates with the database container to perform these operations.

7. **Generate Response**: Once PHP-FPM has processed the request and fetched any necessary data from the database, it generates an HTML response.

8. **Nginx Sends Response**: The generated HTML response is sent back to the Nginx container, which then forwards it to the client's browser.

9. **Client Receives Response**: The client's browser receives the HTML response and renders the webpage.

### Diagram

Here is a simplified diagram to illustrate the workflow:

```  
Client Browser
      |
      v
Nginx Container (Reverse Proxy)
      |
      v
WordPress Container (PHP-FPM)
      |
      v
Database Container (MySQL/MariaDB)
```

### Summary

- **Nginx**: Acts as a web server and reverse proxy, forwarding requests to the WordPress container.
- **WordPress**: Runs the WordPress application and PHP-FPM to handle PHP requests.
- **Database**: Stores and retrieves data for the WordPress application.

By using containers, each component is isolated and can be managed independently, making the system more modular and easier to maintain.

### Configuration

### File permissions

https://www.getpagespeed.com/server-setup/nginx-and-php-fpm-what-my-permissions-should-be

https://www.plesk.com/blog/various/wordpress-file-permissions/



## Nginx

Master process as root user because only root can access low numbered (sub 1000) ports and worker processes as non-root user. 

Test and locate nginx.conf file:

``` bash
nginx -t
$ nginx -t -c /etc/nginx/nginx.conf
```

See all loaded configuration files:
`nginx -T`

## Wordpress Container

The wordpress container consists of Wordpress and PHP-FPM.  
WordPress is an open source website builder and content management system (CMS).  
A content management system (CMS) is software that helps users create, manage, and modify content on a website without the need for technical knowledge.  
**PHP** is the most popular server-side scripting language in web development.  
PHP-FPM works as a process manager, managing PHP processes and handling PHP requests separately from the web server. By doing so, it can efficiently handle multiple PHP requests concurrently, leading to a significant reduction in latency and improved overall performance.