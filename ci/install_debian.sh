#!/bin/bash

# Install script for Debian and Ubuntu based containers.

set -e
set -x

apt-get update
apt-get install --yes apt-transport-https curl tzdata gnupg

cat <<EOF > /etc/apt/sources.list.d/clang.list
deb http://apt.llvm.org/${DISTRIB_CODENAME}/ llvm-toolchain-${DISTRIB_CODENAME}-${CLANG_VERSION} main
deb-src http://apt.llvm.org/${DISTRIB_CODENAME}/ llvm-toolchain-${DISTRIB_CODENAME}-${CLANG_VERSION} main
EOF

curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

# following https://crystal-lang.org/install/on_ubuntu/
curl -fsSL https://crystal-lang.org/install.sh | bash -s -- --version=latest

apt-get update
apt-get install --yes \
  build-essential git \
  crystal libxml2-dev zlib1g-dev libncurses-dev libgc-dev libyaml-dev \
  llvm-${CLANG_VERSION} llvm-${CLANG_VERSION}-dev \
  clang-${CLANG_VERSION} libclang-${CLANG_VERSION}-dev \
  libpcre3-dev cmake libedit-dev
