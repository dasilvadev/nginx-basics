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
