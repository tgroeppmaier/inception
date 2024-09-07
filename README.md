# inception

## Docker

Docker is a tool designed to make it easier to create, deploy, and run applications by using containers. Containers allow a developer to package up an application with all of the parts it needs, such as libraries and other dependencies, and ship it all out as one package.

The difference between Docker and a virtual machine is that Docker does not require a separate operating system for each application. Docker uses operating system level virtualization to deliver software in packages called containers.

Docker runs on the docker engine, which is a client-server application with several moving parts. The docker client talks to the docker daemon, which does the heavy lifting of building, running, and distributing your Docker containers. The docker client and daemon can run on the same system, or you can connect a docker client to a remote docker daemon. The docker client and daemon communicate using a REST API, over UNIX sockets or a network interface.


## Nginx
Nginx is a web server that can also be used as a reverse proxy, load balancer, mail proxy and HTTP cache.

### Nginx Configuration
Master process as root user because only root can access low numbered (sub 1000) ports and worker processes as non-root user. 

Test and locate nginx.conf file:

``` bash
nginx -t
$ nginx -t -c /etc/nginx/nginx.conf
```

See all loaded configuration files:
`nginx -T`

