# README

Build a Docker image to run the latest version of Emacs.

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

# Tips and Tricks

If you are running multiple versions of Emacs **do not use the same
configuration**.  Keep a separate version of your Emacs configuration
for your containerized Emacs version.

Most of the files I'm editing with Emacs are in my `$HOME/git`
directory, so my I set my containerized Emacs instance something like this:

```
mkdir ~/docker-emacs.d
cp ~/.emacs ~/docker-emacs.d/init.el
cd
HOME=$(pwd)

docker run -it --rm  -u $ID \
       -v $HOME/docker-emacs-d:$HOME/.emacs.d \
       -v $HOME/git:$HOME/git \
       -v $HOME/docker-emacs-d/.gitconfig:$HOME/.gitconfig \
       -e HOME=$HOME -e TERM=xterm-256color -e TZ=US/Eastern \
       emacs:latest emacs
```

# Caveats

Used to run Emacs in text mode. I've not tried attempted to build an
image to run using an X server.
