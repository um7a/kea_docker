# kea_docker

Docker image for Kea.

## Usage

```bash
$ make

  TARGETS
    build ... Build docker image local/kea
    clean ... Clean docker image local/kea
    run   ... Run docker container using image local/kea
    stop  ... Stop docker container which was created by run target

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

