# Starknet Node

[![deploy_node_with_balena](https://user-images.githubusercontent.com/13405632/158033973-3cde7cc1-9596-4a4e-bcfe-2221b733df22.svg)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/OdysLam/starknet-node)

The easiest way to deploy a Starknet Node on a Raspberry pi and begin verifying L2 state transitions, directly from your Raspberry pi!

- Find an Ethereum RPC endpoint link (Infura, Alchemy, Pokt, etc.). Note it down.
- Click on "Deploy Node with balena"
- Create an account
- Follow the instructions. At the Application environment variables, replace the `REPLACE_ME` value, of the `ETH_RPC_URL` variable, with the endpoint you noted before.
- If you want, you can also populate `ETH_PASSWORD` with the password of the `ETH_RPC_URL` (if it exists) and `HTTP_RPC` with an `IP:PORT` value for the node to listen for RPC requests.
- Download the OS image and format an SD card with it
- Insert the card to the Raspbery pi, connect it to the power and the internet, let it boot.
- The container will restart and your node will be able to pull the state of blockchain from your RPC endpoint.

balena will automatically build the application from the repository, package it into Docker containers and deliver it to your Raspberry pi to run it. Because the application is compiled on servers and the container images are delivered ready to the device, it will be **much** faster than having to compile the Node on the device itself.

You can also manage your device via balena-cloud:
![image](https://user-images.githubusercontent.com/13405632/158053365-c0d7ac4b-3acf-4cf2-9e36-45b7400027ca.png)

## Join the fleet

This is an open fleet! All devices that join the fleet will run the latest software and placed in a fleet of starknet nodes.

[View the fleet](https://hub.balena.io/gh_odyslam/starknet-node) on balenaHub. The `deploy` button above and `join` in the balenaHub page will produce the same result. You will download an OS image that will automatically add your device to the fleet and download the application (Starknet Node).

![](https://user-images.githubusercontent.com/13405632/158053257-e33c2c77-b620-4dea-83de-e6612301e512.png)

Read more about [Open Fleets](https://www.balena.io/blog/introducing-open-fleets-and-self-submitted-apps-and-blocks-on-balenahub/#:~:text=Set%20the%20project%20as%20an,set%20your%20app%20to%20public!).

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
- [Balena - boot from SSD](https://forums.balena.io/t/how-to-boot-balenaos-on-an-ssd-why-it-matters-and-how-it-works/341836)

You may want to explore **boot from SSD**, as that would speed-up considerably the process of syncing. The greatest bottleneck in a Raspberry pi is the SD card, which not only is slower than an SSD, but also prone to corruptions.

## Kudos

- [Run your first Starknet Node, by DZupp](https://mirror.xyz/0x83857601C1cFA057F2576b343c563BDB9A4C9975/8HfjYCkbid2vlayxyPtSD9_wtb9a-wHb1uOENsAOwng)
- [Pathfinder](https://github.com/eqlabs/pathfinder)
