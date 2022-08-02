# NFT MINTING CONTRACT

This repo is part of my tutorial demonestrating how we can build an arbitraging smart 
contract which attempts to make a profit due to token price defferences among Uniswap 
and Sushiswap. The contract trys to take advantage of Flash loans on a specific token 
from Uniswap LP of specific pair pool.

This project is intended to be used as a learning reference for blockchain 
developers followoing the tutorial in my blog (http://zillo.one/blog/nft-minting), but 
you should be able to follow it by yourself by reading the README and exploring its
`contracts`, `tests`, `scripts` and 'config' files and directories.

## Quick start

The first things you need to do are cloning this repository and installing its
dependencies:

```sh
git clone https://github.com/ZelalemG/crypto-arbitrage.git
cd NFT-MINTING
npm install
```

Once installed, let's run Hardhat's testing network:

```sh
npx hardhat node
```

Then, on a new terminal, go to the repository's root folder and run this to
deploy your contract:

```sh
npx hardhat run scripts/deploy.js --network localhost
```

Finally, we can run the frontend with:

```sh
cd frontend
npm install
npm start
```

Open [http://localhost:3000/](http://localhost:3000/) to see your Dapp. You will
need to have [Metamask](https://metamask.io) installed and listening to
`localhost 8545`.

## User Guide

You can find a more detailed tutorial and more tips on the hardhat's official website (https://hardhat.org/tutorial).

- [Writing and compiling contracts](https://hardhat.org/tutorial/writing-and-compiling-contracts/)
- [Setting up the environment](https://hardhat.org/tutorial/setting-up-the-environment/)
- [Testing Contracts](https://hardhat.org/tutorial/testing-contracts/)
- [Setting up Metamask](https://hardhat.org/tutorial/boilerplate-project#how-to-use-it)
- [Hardhat's full documentation](https://hardhat.org/docs/)

For a complete introduction to Hardhat, refer to [this guide](https://hardhat.org/getting-started/#overview).

## Setting up your editor

[Hardhat for Visual Studio Code](https://hardhat.org/hardhat-vscode) is the official Hardhat extension that adds advanced support for Solidity to VSCode. If you use Visual Studio Code, give it a try!

## Getting help and updates

If you need help with this project, follow ths link to reach me out or get more tutorials (http://zillo.one/)

**Happy _building_!**
