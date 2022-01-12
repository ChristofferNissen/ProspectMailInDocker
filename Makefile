launch:
	prospect-wrapper prospect-mail
	prospect-wrapper-two prospect-mail

kill-containers:
	docker kill prospect-one || docker kill prospect-two  # if error try kill other instance before exit
	docker kill prospect-two

build:
	docker build . -t stifstof/prospect-mail:latest

install:
	docker run -it --rm \
	--volume /usr/local/bin:/target \
	stifstof/prospect-mail:latest install

uninstall:
	docker run -it --rm \
	--volume /usr/local/bin:/target \
	stifstof/prospect-mail:latest uninstall

# convenience jobs

reinstall:
	make uninstall
	make build
	make install

create-empty-config-folders:
	mkdir ~/.config/Prospect_Mail_One/
	mkdir ~/.config/Prospect_Mail_Two/