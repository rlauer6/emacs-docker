# README

Build a docker image to run the latest version of Emacs.

Creates a Docker image by downloading the latest version of emacs,
building and tagging it with the Emacs version number.

# Building the Docker Image

```
make USER=foo
```

# Other Targets

* `clean` - remove Exited containers
* `realclean` - remove failed builds

# Running Emacs

```shell
docker run -it --rm \
  -e TERM=xterm-256color -e TZ=US/Eastern \
  -u 501 \
  -v $HOME:$HOME emacs:latest emacs
```

# Caveats

Used to run Emacs in text mode. I've not tried attempted to build an
image to run using an X server.
