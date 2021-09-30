#!/bin/bash

# Install script for Debian and Ubuntu based containers.

set -e
set -x

apt-get update
apt-get install --yes curl tzdata

# following https://crystal-lang.org/install/on_ubuntu/
curl -fsSL https://crystal-lang.org/install.sh | bash -s -- --version=latest

apt-get update
apt-get install --yes \
  build-essential git \
  crystal libxml2-dev zlib1g-dev libncurses-dev libgc-dev libyaml-dev \
  llvm llvm-dev clang libclang-dev \
  libpcre3-dev cmake libedit-dev
