// SPDX-License-Identifier: MIT

/*
@title Crypto Arbitrage using Lego bricks (UniSwap and sushiSwap Protocols)
@license GNU GPLv3
@author Zelalem Gebrekirstos
@notice ...
This repo is part of my tutorial demonestrating how we can build an arbitraging smart contract
which attempts to make a profit due to token price defferences among Uniswap and Sushiswap. 
The contract trys to take advantage of Flash loans on a specific token from Uniswap LP of specific 
pair pool.

@Notice You may read a detailed explanation of my blog at http://zillo.one/blog-crypto-arbitrage
or reach me out via info@zillo.one
*/

pragma solidity >=0.6.2;

import "./UniswapV2Library.sol";
import "./IUniswapV2Router02.sol";
import "./IUniswapV2Pair.sol";
import "./IUniswapV2Factory.sol";
import "./IERC20.sol";

contract CryptoArbitrage {
    address constant UNI_ADDRESS = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    address constant SUSHI_ADDRESS = 0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F;
    uint deadline = block.timestamp + 300;

    function InitiateProcess(
        address token0,
        address token1,
        uint amount0,
        uint amount1
    ) external {
        address pairsPoolAddress = IUniswapV2Factory(UNI_ADDRESS).getPair(
            token0,
            token1
        );
        require(pairsPoolAddress != address(0), "pairs-pool not available");

        IUniswapV2Pair(pairsPoolAddress).swap(
            amount0,
            amount1,
            address(this),
            bytes("anything")
        );
    }

    //---This is a standard call back function to be called by Uniswap contract---\\
    function uniswapV2Call(
        address _sender,
        uint _amount0,
        uint _amount1,
        bytes calldata _data
    ) external {
        address token0 = IUniswapV2Pair(msg.sender).token0();
        address token1 = IUniswapV2Pair(msg.sender).token1();

        address[] memory path = new address[](2);
        uint amountToken;

        assert(
            msg.sender == IUniswapV2Factory(UNI_ADDRESS).getPair(token0, token1)
        );
        require(_amount0 == 0 || _amount1 == 0);

        if (_amount0 == 0) {
            amountToken = _amount1;
            path[0] = token1;
            path[1] = token0;
        } else {
            amountToken = _amount0;
            path[0] = token0;
            path[1] = token1;
        }

        IERC20 token = IERC20(path[0]);

        token.approve(SUSHI_ADDRESS, amountToken);

        uint totalDebt = UniswapV2Library.getAmountsIn(
            UNI_ADDRESS,
            amountToken,
            path
        )[0];
        uint swappedAmount = IUniswapV2Router02(SUSHI_ADDRESS)
            .swapExactTokensForTokens(
                amountToken,
                totalDebt,
                path,
                msg.sender,
                deadline
            )[1];

        IERC20 swappedToken = IERC20(path[1]);
        swappedToken.transfer(msg.sender, totalDebt);
        swappedToken.transfer(tx.origin, swappedAmount - totalDebt);
    }
}
