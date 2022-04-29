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

Balena will automatically build the application from the repository, package it into Docker containers and deliver it to your Raspberry pi. Building the containers on the cloud server is much faster than building them on the device itself.

You can also manage your device via balena-cloud:
![image](https://user-images.githubusercontent.com/13405632/158053365-c0d7ac4b-3acf-4cf2-9e36-45b7400027ca.png)

## Services

- `starknet-node`: The starknet node. You can access it's RPC on port `9545`.
- `netdata`: The monitoring agent. A detailed per-second view of device. You can access the dashboard on port `19999`. The agent is offline and transmits no information to any cloud.
- `caddy`: Serves the Node Dashboard, offers basic auth and reverse proxy the Netdata Dashboard

## Dashboard

![dashboard](https://user-images.githubusercontent.com/13405632/165237550-cd2b1540-daed-4679-9cd4-eb812cfdafdb.png)

Starknet-Node comes with a simple dashboard that is served by the device. That way, you can quickly inspect it's state, without having to visit balena-cloud.

To access the dashboard:
- If your computer is in the same local network as the device, you can either:
    - Visit `starknet.local`.  If this doesn't work, it's because sometimes `avahi` which is responsible for the `.local` domain translation fails to work
    - Visit balena-cloud and find the IP of your device. Type that IP in your browser
- Visit balena-cloud and activate `public device URL`. Visit that URL

The dashboard offers:
- Helpful links for the device and docs. It links to the Netdata Dashboard of the device (served locally) and the dashboard of your balena-cloud account
- Charts with **live** metrics from the device. It shows an overview of the device (e.g RAM), as also pathfinder-specific metrics
- Logs that are being streamed by the device, directly to the browser. *This feature is very flakey and we want to improve it*.

### Paths
- `/` is redirected to `/dashboard/`, where the dashboard is served.
- `/netdata` is where the Netdata dashboard is served.

## Netdata Pathfinder monitoring

We have implemented an integration between Pathfinder and Netdata, the monitoring agent that is installed on the device. Netdata gathers data from Pathfinder, stores them in it's Time-Series database and visualises them in it's dashboard. We use some of Netdata's charts in the Starknet Node dashboard we described above.

Currently, the integration gathers two metrics from pathfinder, using it's RPC endpoint:
- `starknet_syncing`: if `True`, then the chart shows a value of `1`. Otherwise, it's `0`.
- `starknet_blockNumber`: The latest blockNumber that got verified by the Node.

### Extending the integration

To extend the integration, you need to write some simple python code. Open `/netdata/pathfinder.chart.py` and perform the following:
- Define a new Chart
- Gather data for that Chart

Using `requests`, it's trivial to gather arbitrary data from Pathfinder's API.

Some helpful Documentation:
- [Python plugins for Netdata](https://learn.netdata.cloud/docs/agent/collectors/python.d.plugin)
- [How to write a custom python collector](https://learn.netdata.cloud/guides/python-collector)

## Environment Variables

- `PATHFINDER_ETHEREUM_API_URL`: Ethereun endpoint url. e.g `https://eth-mainnet.gateway.pokt.network/v1/XXXXXXX`. Currently the API endpoint is provided and sponsored by Starkware.
- `PATHFINDER_HTTP_RPC_ADDRESS`: IP and port at which the node accepts RPC requests. Default: `0.0.0.0:9545`
- `PATHFINDER_ETHEREUM_API_PASSWORD`: Password for the ethereum endpoint. Default is empty.
- `NODE_IDLE`: Helper env variable that will idle the `starknet-pathfinder` container instead of running pathfinder. That way, you can `ssh` into the container and debug/test. Default: `0`.
- `NODE_LOCATION`: If `ON`, the device pings a StarkWare website at regular intervals, so that the approximate Node location may be inferred from the HTTP request. StarkWare uses this information to create a map of StarkNet Nodes. StarkWare will not share this information with any 3rd party, and the actual HTTP request does not transmit any information about the device. The location of the device is based solely based on the IP that the HTTP request originates from.
-  `NODE_LOCATION_API`: Location API endpoint. Default: `https://starknet.io/rpi-node/`
-  `CADDY_USERNAME`: Username for the dashboard's basic auth. Default: `starknet`
-  `CADDY_PASSWORD`: Password for the dashboard's basic auth. Default: `starknet`

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
- Starkware for providing a Grant and sponsoring the Alchemy ETH RPC endpoint
