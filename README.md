# Starknet Node

[![deploy_node_with_balena](https://user-images.githubusercontent.com/13405632/158033973-3cde7cc1-9596-4a4e-bcfe-2221b733df22.svg)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/OdysLam/starknet-node)

The easiest way to deploy a Starknet Node on a Raspberry pi and begin verifying L2 state transitions, directly from your Raspberry pi!

- Find an Ethereum RPC endpoint link (Infura, Alchemy, Pokt, etc.). Note it down.
- Click on "Deploy Node with balena"
- Create an account
- Follow the instructions. At the application environment variables, replace the "REPLACE_ME" value, of the `ETH_RPC_URL` variable, with the endpoint you noted before.
- Download the OS image and format an SD card with it
- Insert the card to the Raspbery pi, connect it to the power and the internet, let it boot.
- The container will restart and your node will be able to pull the state of blockchain from your RPC endpoint.

balena will automatically build the application from the repository, package it into Docker containers and deliver it to your Raspberry pi to run it. Because the application is compiled on servers and the container images are delivered ready to the device, it will be **much** faster than having to compile the Node on the device itelf.

## Services

- `starknet-node`: The starknet node. You can access it's RPC on port `9545`.
- `netdata`: The monitoring agent. A detailed per-second view of device. You can access the dashboard on port `19999`. The agent is offline and transmits no information to any cloud.

## Environment Variables

- `ETH_RPC_URL`: Ethereun endpoint url. e.g `https://eth-mainnet.gateway.pokt.network/v1/XXXXXXX`
- `RPC_URL`: IP and port at which the node accepts RPC requests. Default: `0.0.0.0:9545`
- `ETH_PASSWORD`: Password for the ethereum endpoint. Default is empty.
- `IDLE`: Helper env variable that will idle the `starknet-pathfinder` container instead of running pathfinder. That way, you can `ssh` into the container and debug/test. Default: `0`.

## Resources
- [Deploy with balena](https://www.balena.io/docs/learn/deploy/deploy-with-balena-button/)
- [What is balena](https://www.balena.io/what-is-balena/)
- [Netdata](https://github.com/netdata/netdata)

## Kudos

- [Run your first Starknet Node, by DZupp](https://mirror.xyz/0x83857601C1cFA057F2576b343c563BDB9A4C9975/8HfjYCkbid2vlayxyPtSD9_wtb9a-wHb1uOENsAOwng)
- [Pathfinder](https://github.com/eqlabs/pathfinder)

-
