# Basic examples of nginx resources. <!-- omit in toc -->

## Table of Contents <!-- omit in toc -->
- [Overview](#overview)
- [Usage](#usage)
  - [Serving static content](#serving-static-content)

## Overview

This is not a tutorial on nginx resources. It's just a collection of basic examples of nginx features, written as I learn about them. Feel free to use them as a reference or modify them to suit your needs.

## Usage

To run the examples, you need to have [Docker](https://www.docker.com/) installed. Then, you can run the following command:

```bash
alias nb="./nginx-basics"
```

you need to be located in the root directory of this repository. The created alias is only valid for the current terminal session. To make it permanent, add the alias to your `.bashrc` or `.zshrc` file. I chose `nb` as an alias, but you can use whatever you like. After that you can run the examples.

### Serving static content

To run this example, you need to run the following command:

```bash
$ nb run serving-static-content
```

If you don't have the nginx image locally, it is downloaded from [Docker Hub](https://hub.docker.com/). After that, you can access the static content in your browser at [http://localhost:80/](http://localhost:80/).

To stop the container, run the following command:

```bash
$ nb stop
```

and the current example will stop. If you make any changes to the `nginx.conf` file, for this example you will need to restart the container with the `nb restart` command.

### Load balancer

To run this example, you need to create a network with Docker. Run the following command:

```bash
$ docker network create load-balancer-network
```

After that you need the `backend-server` image. Create the image by running the following command:

```bash
$ docker image build resources/load-balancer/server -t backend-server
```

If you want to delete the network after the end of the example, just run docker network rm load-balancer-network. After creating the network, just run:

```bash
$ nb run load-balancer
```

To check the result, run the client with:

```bash
$ nb run client-load-balancer
```

This resource uses the algorithm Round Robin. This algorithm ensures that all the servers listed in the upstream block respond to requests in a circular manner.
