# kea_docker

Docker image for Kea.

## Usage

```bash
$ make

  TARGETS
    build  ... Build docker image kea
    save   ... Save docker image kea to file
    clean  ... Clean docker image kea
    run    ... Run docker container using image kea
    attach ... Attach on docker container using image kea
    stop   ... Stop docker container which was created by run target
    logs   ... Show logs of docker container

```

### Build docker image

```bash
$ make build
```

### Run container

```bash
$ make run
```

### Stop container

```bash
$ make stop
```

### Delete docker image

```bash
$ make clean
```

