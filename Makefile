include .env

launch:
	prospect-wrapper prospect-mail
	prospect-wrapper-two prospect-mail

kill-containers:
	${CONTAINER_ENGINE} kill prospect-one || ${CONTAINER_ENGINE} kill prospect-two  # if error try kill other instance before exit
	${CONTAINER_ENGINE} kill prospect-two

build:
	${CONTAINER_ENGINE} build -t docker.io/stifstof/prospect-mail:latest -f Containerfile .

build-no-cache:
	${CONTAINER_ENGINE} build --no-cache -t docker.io/stifstof/prospect-mail:latest -f Containerfile .

install:
	${CONTAINER_ENGINE} run -it --rm \
	--volume ${PWD}/bin:/target \
	docker.io/stifstof/prospect-mail:latest install

uninstall:
	${CONTAINER_ENGINE} run -it --rm \
	--volume ${PWD}/bin:/target \
	docker.io/stifstof/prospect-mail:latest uninstall

# convenience jobs

push:
	echo ${DOCKERHUB_STIFSTOF_PW} | ${CONTAINER_ENGINE} login docker.io -u stifstof --password-stdin
	${CONTAINER_ENGINE} push docker.io/stifstof/prospect-mail:latest

reinstall:
	make uninstall
	make build
	make install

create-empty-config-folders:
	mkdir ~/.config/Prospect_Mail_One/
	mkdir ~/.config/Prospect_Mail_Two/

add-to-path:
	export PATH=$PATH:/home/cn/Documents/git/prospect-mail-docker/bin

podman_runtime:
	rm -f .env
	echo "CONTAINER_ENGINE=podman" >> .env

docker_runtime:
	rm -f .env
	echo "CONTAINER_ENGINE=docker" >> .env

current_runtime:
	cat .env
