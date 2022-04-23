# Starknet Node

[![deploy_node_with_balena](https://user-images.githubusercontent.com/13405632/158033973-3cde7cc1-9596-4a4e-bcfe-2221b733df22.svg)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/OdysLam/starknet-node)

The easiest way to deploy a Starknet Node on a Raspberry pi and begin verifying L2 state transitions, directly from your Raspberry Pi!

- Click on "Deploy Node with balena"
- Create a balena-cloud account
- In the "Create and deploy to fleet" modal, choose your default device type (e.g Raspberry Pi 400)
- Click on "Create and Deploy"
- Click on "Add a device"
- Click on "Flash" and follow the instructions to download and install balena Etcher.
- If Etcher doesn't open automatically with our OS loaded, click the arrow in the button and download balenaOS
- Follow the instructions of the modal to "flash" the OS in the storage medium (e.g SD card)
- Click on "Wifi + Ethernet" in the "Network Connection" section of the modal. Type the credentials of your wifi network. That way, the device will connect automatically to wifi
- Insert the card to the Raspbery pi, connect power + ethernet (if you didn't configure wifi)
- Let it boot 🔜
- Visit balena-cloud and view the logs of the device

balena will automatically build the application from the repository, package it into Docker containers and deliver it to your Raspberry pi to run it. Building the containers on the cloud server is much faster than building them on the device itself.

You can also manage your device via balena-cloud:
![image](https://user-images.githubusercontent.com/13405632/158053365-c0d7ac4b-3acf-4cf2-9e36-45b7400027ca.png)

## Services

- `starknet-node`: The starknet node. You can access it's RPC on port `9545`.
- `netdata`: The monitoring agent. A detailed per-second view of device. You can access the dashboard on port `19999`. The agent is offline and transmits no information to any cloud.

## Environment Variables

- `ETH_RPC_URL`: Ethereun endpoint url. e.g `https://eth-mainnet.gateway.pokt.network/v1/XXXXXXX`. Currently the API endpoint is provided and sponsored by Starkware.
- `RPC_URL`: IP and port at which the node accepts RPC requests. Default: `0.0.0.0:9545`
- `ETH_PASSWORD`: Password for the ethereum endpoint. Default is empty.
- `IDLE`: Helper env variable that will idle the `starknet-pathfinder` container instead of running pathfinder. That way, you can `ssh` into the container and debug/test. Default: `0`.
- `LOCATION`: If `ON`, the device pings a StarkWare website at regular intervals, so that the approximate Node location may be inferred from the HTTP request. StarkWare uses this information to create a map of StarkNet Nodes. StarkWare will not share this information with any 3rd party, and the actual HTTP request does not transmit any information about the device. The location of the device is based solely based on the IP that the HTTP request originates from.

## Test a new device

It's very easy to test a device that is not shown in the list of supported devices.

Follow the instructions as described above and at the modal shown below, search your device (e.g Raspberry pi 3) and choose the 64bit version of the OS (there is a 64 in the name).

![](https://user-images.githubusercontent.com/13405632/158076094-8044d2b0-85dc-4940-acb5-ea27a8551a47.png)

After you finish the installation, visit the cloud dashbord of balena-cloud and see the logs. If everything works as expected, then open a GitHub issues in this repository to let me know.

## Resources

- [Deploy with balena](https://www.balena.io/docs/learn/deploy/deploy-with-balena-button/)
- [What is balena](https://www.balena.io/what-is-balena/)
- [Netdata](https://github.com/netdata/netdata)

You may want to explore **boot from SSD**, as that would considerably speed-up the process of syncing. The greatest bottleneck in a Raspberry pi is the SD card, as it's also much slower than expected for a storage medium, but also is prone to corruptions.
- [Balena - boot from SSD](https://forums.balena.io/t/how-to-boot-balenaos-on-an-ssd-why-it-matters-and-how-it-works/341836)

## Kudos

- [Run your first Starknet Node, by DZupp](https://mirror.xyz/0x83857601C1cFA057F2576b343c563BDB9A4C9975/8HfjYCkbid2vlayxyPtSD9_wtb9a-wHb1uOENsAOwng)
- [Pathfinder](https://github.com/eqlabs/pathfinder)
