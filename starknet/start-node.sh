#!/bin/bash
set -e
# set defaults
cd ~/pathfinder
cargo run --release --bin pathfinder -- --ethereum.url $RPC_URL
