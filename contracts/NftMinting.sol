// SPDX-License-Identifier: MIT

/*
@title NFT Minting (using openzeppelin and hardhat)
@license GNU GPLv3
@author Zelalem Gebrekirstos
@notice An NFT minting and selling smart contract which allows the creator of the  
contract to mint NFT and list them for sale with a min price in Ether. 
This repo is part of my tutorial on how to mint NFTs which is available in my blog.

@Notice You may read a detailed explanation of my blog at http://zillo.one/blog-go-fund-me
or reach me out via info@zillo.one
*/

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NftMinting is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("nft-minting", "MTK") {}

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://";
    }

    function mintToken(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function buyToken(uint256 _tokenId) public payable {
        require(msg.sender != address(0), "invalide buyer address");
        require(_exists(_tokenId), "Token doesn't exist");
        require(msg.value >= 0.02 ether, "Minimum price is 0.2 eth");
        _safeTransfer(owner(), msg.sender, _tokenId, "");
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
