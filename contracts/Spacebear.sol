// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@ganache/console.log/console.sol";

contract Spacebear is ERC721, Ownable {
    uint256 private _nextTokenId;

    constructor()
        ERC721("Spacebear", "SBR")
        Ownable(msg.sender)
    {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://ethereum-blockchain-developer.com/2022-06-nft-truffle-hardhat-foundry/nftdata/";
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }

    function buyToken() public payable {
        uint256 tokenId = _nextTokenId++;
        console.log("got here", tokenId, msg.value);
        require(msg.value == tokenId * 0.1 ether, "Wrong amount of funds sent");
        _safeMint(msg.sender, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function tokenURI(uint256 tokenId)
        public
        pure
        override(ERC721)
        returns (string memory)
    {
        return string(abi.encodePacked(_baseURI(), "spacebear_", (tokenId+1), ".json"));
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
