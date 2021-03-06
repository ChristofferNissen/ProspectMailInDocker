# Prospect Mail in Container
![](https://i.imgur.com/yI20s0A.png)


This projects objective is to provide Prospect-Mail as a container to enable multiple accounts to be used simultaniously.

Currently the project supports Docker and Podman. Select which runtime you want with the convenient make targets:

Makefile (System setup)
- docker_runtime
- podman_runtime
- current_runtime

The Makefile contains the relevant commands to use the application. The project works with two accounts, but can be extended to any number of accounts (not tested).

Teams is not the most stable application, so you can expect to get familiar with the two first commands in the Maefile:

Makefile
- launch
- kill-containers
- install
- uninstall
- build

# Supported Container Runtimes

Podman has been added as an alternative to Docker, to enable use on systems without root access. When using Podman, the container user's root will only have the permission of the user executing podman, and the container user will have UID > 10000 as per best practice recommendations.

# Old Readme

This project is inspired from te works of gfa01/slack-desktop, but instead for Prospect-Mail. The old README explains the use of PulseAudio and XServer well

You can find the README from the project which this is based on in the folder Old/

## To get up and running

Ensure you have two Microsoft configurations in ~/.config, mine are named Microsoft and MicrosoftTwo

Either use the images i pushed to dockerhub by directly running

```
make install
make launch
```

and two Prospect-Mail applications should appear on your screen.

Do you wish to modify the image, you can change the image name in the scripts in the scripts/ folder.


## Uninstall

Simply run

```
make kill-containers
make uninstall
```
