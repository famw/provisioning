#!/usr/bin/env bash
# vim: set ts=2 sw=2 expandtab :

set -o errexit
set -o pipefail
set -o nounset

# IMPORTANT: run this script using `sudo`

# Required for wine
enable_32bit_arch() {
  dpkg --add-architecture i386 
}

add_wine_repository() {
  add-apt-repository -y ppa:wine/wine-builds
}

update_pkgs() {
  apt-get -y update
}

install_wine() {
  apt-get -y install --install-recommends wine
}

install_xvfb() {
  apt-get -y install xvfb
}

install_x11vnc() {
  apt-get -y install x11vnc
}

install_pulseaudio() {
  apt-get -y install pulseaudio
}

main() {
  enable_32bit_arch
  add_wine_repository
  update_pkgs
  install_wine
  install_xvfb
  install_x11vnc
  install_pulseaudio
}

main
