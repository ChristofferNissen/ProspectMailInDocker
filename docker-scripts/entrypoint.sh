#!/bin/bash
set -e
set -x

USER_UID=${USER_UID:-1000}
USER_GID=${USER_GID:-1000}

DESKTOP_USER=cn # this needs to be the same name as the host user

install_host() {
  echo "Installing prospect-wrapper..."
  install -m 0755 /var/cache/app/prospect-wrapper /target/
  install -m 0755 /var/cache/app/prospect-wrapper-two /target/
  echo "Installing prospect-mail..."
  ln -sf prospect-wrapper /target/prospect-mail
  ln -sf prospect-wrapper-two /target/prospect-mail-two
}

uninstall_host() {
  echo "Uninstalling prospect-wrapper..."
  rm -rf /target/prospect-wrapper
  rm -rf /target/prospect-wrapper-two
  echo "Uninstalling prospectmail..."
  rm -rf /target/prospect-mail
  rm -rf /target/prospect-mail-two
}

create_user() {
  # create group with USER_GID
  if ! getent group ${DESKTOP_USER} >/dev/null; then
    groupadd -f -g ${USER_GID} ${DESKTOP_USER} >/dev/null 2>&1
  fi

  # create user with USER_UID
  if ! getent passwd ${DESKTOP_USER} >/dev/null; then
    adduser --disabled-login --uid ${USER_UID} --gid ${USER_GID} \
      --gecos 'Prospect-Mail' ${DESKTOP_USER} >/dev/null 2>&1
  fi
  chown ${DESKTOP_USER}:${DESKTOP_USER} -R /home/${DESKTOP_USER}
}

grant_access_to_video_devices() {
  for device in /dev/video*; do
    if [[ -c $device ]]; then
      VIDEO_GID=$(stat -c %g $device)
      VIDEO_GROUP=$(stat -c %G $device)
      if [[ ${VIDEO_GROUP} == "UNKNOWN" ]]; then
        VIDEO_GROUP=prospectmailvideo
        groupadd -g ${VIDEO_GID} ${VIDEO_GROUP}
      fi
      usermod -a -G ${VIDEO_GROUP} ${DESKTOP_USER}
      break
    fi
  done
}

launch() {
  cd /home/${DESKTOP_USER}
  sudo -HEu ${DESKTOP_USER} PULSE_SERVER=/run/pulse/native $@
}

case "$1" in
install)
  install_host
  ;;
uninstall)
  uninstall_host
  ;;
prospect-mail)
  create_user
  grant_access_to_video_devices
  echo "$1"
  launch $@
  ;;
*)
  exec $@
  ;;
esac
