# LLVM 11 to 14 is available for bullseye (Debian 11, stable).
# LLVM 7 to 14 is available for buster (Debian 10, old-stable).
ARG DEBIAN_CODENAME=bullseye

FROM debian:${DEBIAN_CODENAME}

ARG DEBIAN_CODENAME
ARG CRYSTAL_VERSION=latest
ARG CRYSTAL_CHANNEL=stable
ARG LLVM_VERSION=11

RUN apt-get update && apt-get install --yes curl tzdata gnupg

# add llvm
RUN echo deb http://apt.llvm.org/${DEBIAN_CODENAME}/ llvm-toolchain-${DEBIAN_CODENAME}-${LLVM_VERSION} main >> /etc/apt/sources.list && \
    echo deb-src http://apt.llvm.org/${DEBIAN_CODENAME}/ llvm-toolchain-${DEBIAN_CODENAME}-${LLVM_VERSION} main >> /etc/apt/sources.list && \
    curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

# add crystal (internally do apt-get crystal${CRYSTAL_VERSION})
RUN curl -fsSL https://crystal-lang.org/install.sh | bash -s -- --version=${CRYSTAL_VERSION} --channel=${CRYSTAL_CHANNEL}

RUN apt-get update && \
    apt-get install --yes \
    build-essential git \
    libxml2-dev zlib1g-dev libncurses-dev libgc-dev libyaml-dev \
    llvm-${LLVM_VERSION} llvm-${LLVM_VERSION}-dev clang-${LLVM_VERSION} libclang-${LLVM_VERSION}-dev \
    libpcre3-dev cmake libedit-dev

COPY . /bindgen

WORKDIR /bindgen/clang
RUN cmake . && make
WORKDIR /bindgen
