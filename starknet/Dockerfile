FROM debian:latest
ARG PATHFINDER_VERSION=v0.1.4-alpha

# Install depedencies
RUN apt-get update && apt-get --no-install-recommends install -y curl wget vim python3-pip build-essential libssl-dev libffi-dev python3-dev libgmp-dev fastecdsa pkg-config

# Install rust related
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && rustup update stable
# Add .cargo/bin to PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# Install pathfinder
RUN git clone --branch $PATHFINDER_VERSION  https://github.com/eqlabs/pathfinder.git pathfinder && cd pathfinder && cargo build --release --bin pathfinder && pip install --upgrade pip && pip install -r requirements-dev.txt

# Copy entrypoing script to container
COPY start-node.sh /usr/bin/start-node
# Make script executable
RUN chmod +x /usr/bin/start-node
ENTRYPOINT start-node
