#!/usr/bin/env bash
# vim: set ts=2 sw=2 expandtab :

set -o errexit
set -o pipefail
set -o nounset

declare -r WORKSPACE=~/workspace

# IMPORTANT: run this script using `sudo`

create_workspace() {
  mkdir -p ${WORKSPACE}
}

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

install_mxe() {
  git clone https://github.com/mxe/mxe.git ${WORKSPACE}/mxe

  pushd ${WORKSPACE}/mxe
  MXE_TARGETS='x86_64-w64-mingw32.static i686-w64-mingw32.static' make gcc
  popd
}

install_mxe_requirements() {
  apt-get install -y \
    autoconf automake autopoint bash bison bzip2 flex gettext\
    git g++ gperf intltool libffi-dev libgdk-pixbuf2.0-dev \
    libtool libltdl-dev libssl-dev libxml-parser-perl make \
    openssl p7zip-full patch perl pkg-config python ruby scons \
    sed unzip wget xz-utils libtool-bin
}

install_wine() {
  apt-get -y install --install-recommends winehq-staging
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
  create_workspace
  enable_32bit_arch
  add_wine_repository
  update_pkgs
  install_mxe_requirements
  install_mxe
  install_wine
  install_xvfb
  install_x11vnc
  install_pulseaudio
}

main
