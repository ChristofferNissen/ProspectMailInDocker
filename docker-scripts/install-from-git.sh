#!/bin/bash
git clone https://github.com/julian-alarcon/prospect-mail.git
cd prospect-mail
yarn
yarn run dist:linux
ls -lah ./dist
apt-get install -y ./dist/prospect-mail_0.5.0-beta_amd64.deb