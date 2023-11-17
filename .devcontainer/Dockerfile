# If you want to use this Dockerfile instead of the image - remove the image from devcontainer.json and rename __build to build
FROM ubuntu:22.04 as builder

# Install system packages
RUN apt -yq update && \
    apt -yqq install --no-install-recommends curl ca-certificates build-essential pkg-config libssl-dev llvm-dev \
    liblmdb-dev clang cmake rsync libunwind-dev sudo git && \
    rm -rf /var/lib/apt/lists/*

# Resolve libssl compatibility issue
RUN curl http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb --output libssl1.deb && \
    dpkg -i libssl1.deb && \
    rm libssl1.deb

# Install Node.js using nvm
ENV NVM_DIR=/root/.nvm
ENV PATH="${NVM_DIR}/versions/node/v18.1.0/bin:${PATH}"
RUN curl --fail -sSf https://raw.githubusercontent.com/creationix/nvm/v0.39.1/install.sh | bash && \
    . "${NVM_DIR}/nvm.sh" && \
    nvm install 18.1.0 && \
    nvm use v18.1.0 && \
    nvm alias default v18.1.0

# Install latest available version of dfx
RUN sh -ci "$(curl -fsSL https://smartcontracts.org/install.sh)"

# Init dfx
RUN sh -ci "dfx start"

# Install mops
RUN sh -ci "npm i -g ic-mops"

# Init mops
RUN sh -ci "mops init"

# Stop dfx
RUn sh -ci "dfx stop"
