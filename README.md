# Starknet Node

![deploy-button](https://user-images.githubusercontent.com/13405632/158033926-28a1ff8e-8809-42b4-abbc-d594ae9aaf8d.svg)

The easiest way to deploy a Starknet Node on a Raspberry pi and begin verifying L2 state transitions, directly from your Raspberry pi!

- Find an Ethereum RPC endpoint link (Infura, Alchemy, Pokt, etc.). Note it down.
- Click on "Deploy Node with balena"
- Create an account
- Follow the instructions. At the application environment variables, replace the "REPLACE_ME" value, of the `ETH_RPC_URL` variable, with the endpoint you noted before.
- Download the OS image and format an SD card with it
- Insert the card to the Raspbery pi, connect it to the power and the internet, let it boot.
- The container will restart and your node will be able to pull the state of blockchain from your RPC endpoint.

balena will automatically build the application from the repository, package it into Docker containers and deliver it to your Raspberry pi to run it. Because the application is compiled on servers and the container images are delivered ready to the device, it will be **much** faster than having to compile the Node on the device itelf.

## Environment Variables

- `ETH_RPC_URL`: https://eth-mainnet.gateway.pokt.network/v1/XXXXXXX

## Resources
- [Deploy with balena](https://www.balena.io/docs/learn/deploy/deploy-with-balena-button/)
- [What is balena](https://www.balena.io/what-is-balena/)
