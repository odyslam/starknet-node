########################################
# Stage 1: Build the pathfinder binary #
########################################

# The Dockerfile is based on the work by the Pathfinder team, with some small modifications
# to enable compilation on multiple architectures.
# Original: https://github.com/eqlabs/pathfinder/blob/main/Dockerfile
#
FROM rust:1.59-alpine AS rust-builder

RUN apk add --no-cache musl-dev gcc openssl-dev git

RUN git clone https://github.com/eqlabs/pathfinder /tmp/pathfinder

WORKDIR /usr/src/pathfinder

# Build only the dependencies first. This utilizes
# container layer caching for Rust builds
RUN mkdir crates
RUN cargo new --lib crates/pedersen
# Correct: --lib. We'll handle the binary later.
RUN cargo new --lib crates/pathfinder
RUN cp /tmp/pathfinder/Cargo.toml Cargo.toml

RUN cp /tmp/pathfinder/crates/pathfinder/Cargo.toml crates/pathfinder/Cargo.toml
RUN cp /tmp/pathfinder/crates/pedersen/Cargo.toml crates/pedersen/Cargo.toml
RUN cp -R /tmp/pathfinder/crates/pedersen/benches crates/pedersen/benches

RUN RUSTFLAGS='-L/usr/lib -Ctarget-feature=-crt-static' cargo build --release

# Compile the actual libraries and binary now
RUN cp -R /tmp/pathfinder/* .

# Mark these for re-compilation
RUN touch crates/pathfinder/src/lib.rs
RUN touch crates/pedersen/src/lib.rs

RUN RUSTFLAGS='-L/usr/lib -Ctarget-feature=-crt-static' cargo build --release
# Copy binary to hardcoded path so we can find it later at the Dockerfile
RUN mkdir bins && cp $(find ./target -name 'pathfinder') ./bins/pathfinder
# Stage 2: Build the Python libraries #
#######################################
FROM python:3.8-alpine AS python-builder

RUN apk add --no-cache gcc musl-dev gmp-dev g++

# bring in the pathfinder repo from the previous build
COPY --from=rust-builder /tmp/pathfinder /tmp/pathfinder

WORKDIR /usr/share/pathfinder

# Copy the py directory
RUN cp -R /tmp/pathfinder/py ./py

RUN python3 -m pip install --upgrade pip
RUN ls ./py && python3 -m pip install -r ./py/requirements-dev.txt

# This reduces the size of the python libs by about 50%
ENV PY_PATH=/usr/local/lib/python3.8/
RUN find ${PY_PATH} -type d -a -name test -exec rm -rf '{}' +
RUN find ${PY_PATH} -type d -a -name tests  -exec rm -rf '{}' +
RUN find ${PY_PATH} -type f -a -name '*.pyc' -exec rm -rf '{}' +
RUN find ${PY_PATH} -type f -a -name '*.pyo' -exec rm -rf '{}' +

#######################
# Final Stage: Runner #
#######################
FROM python:3.8-alpine AS runner

RUN apk add --no-cache tini

COPY --from=rust-builder ["/usr/lib/libstdc++.so.6", "/usr/lib/libgcc_s.so.1", "/usr/lib/libgmp.so.10", "/usr/lib/" ]
COPY --from=rust-builder /usr/src/pathfinder/bins/pathfinder /usr/local/bin/pathfinder
COPY --from=python-builder /usr/local/lib/python3.8/ /usr/local/lib/python3.8/
COPY --from=rust-builder /usr/src/pathfinder/bins/pathfinder /usr/local/bin/pathfinder
# Create directory and volume for persistent data
RUN mkdir -p /usr/share/pathfinder/data
RUN chown 1000:1000 /usr/share/pathfinder/data
VOLUME /usr/share/pathfinder/data

# Move the start script in the Dockerfile
COPY start-node.sh /tmp/start-node.sh
RUN chmod +x /tmp/start-node.sh && mv /tmp/start-node.sh /usr/local/bin/start-node.sh && chmod 755 /usr/local/bin/start-node.sh

# Change to the Pathfinder user
USER 1000:1000
WORKDIR /usr/share/pathfinder/data

ENTRYPOINT ["sh", "/usr/local/bin/start-node.sh"]
