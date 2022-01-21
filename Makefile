launch:
	prospect-wrapper prospect-mail
	prospect-wrapper-two prospect-mail

kill-containers:
	podman kill prospect-one || podman kill prospect-two  # if error try kill other instance before exit
	podman kill prospect-two

build:
	podman build . -t docker.io/stifstof/prospect-mail:latest

install:
	podman run -it --rm \
	--volume ./bin:/target \
	docker.io/stifstof/prospect-mail:latest install

uninstall:
	podman run -it --rm \
	--volume ./bin:/target \
	docker.io/stifstof/prospect-mail:latest uninstall

# convenience jobs

reinstall:
	make uninstall
	make build
	make install

create-empty-config-folders:
	mkdir ~/.config/Prospect_Mail_One/
	mkdir ~/.config/Prospect_Mail_Two/