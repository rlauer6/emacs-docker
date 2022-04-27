TAG=emacs:latest

all: emacs-latest

docker-build.log: Dockerfile
	set -o pipefail; \
	user=$(USER); \
	user=$${user:-root}; \
	GROUP_ID=$$(id -u $(USER)); \
	docker build \
	  --build-arg user=$(USER) \
	  --build-arg group=$$GROUP_ID \
	  -f $< . -t $(TAG) | tee $@ || rm "$@"

emacs-latest: docker-build.log
	docker run --rm emacs:latest \
	  emacs --version | head -1 | awk '{ print $$3}' > $@
	docker tag emacs:latest emacs:$$(cat $@)

.PHONY: clean
clean:
	rm -f docker-build.log emacs-latest
	for d in $$(docker ps -a | grep Exit); do \
	  docker rm $$d; \
	done

.PHONY: realclean
realclean: clean
	if test -e "emacs-latest"; then \
	  docker rmi $$(cat emacs-latest); \
	fi
	for d in $$(docker ps -a | grep Exit); do \
	  docker rm $$d; \
	done
	for d in $$(docker image list | grep "^<none" | awk '{print $$3}'); do \
	  docker rmi $$d; \
	done
