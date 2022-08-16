//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MEFANFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping (address => bool) minters;

    constructor() ERC721("META FACE NFT", "MEFANFT") {
        minters[msg.sender] = true;
    }

    modifier onlyMinters {
        require(minters[msg.sender], "Only owner can mint.");
        _;
    }

    function setMinters(address _address, bool _value) public onlyOwner {
        minters[_address] = _value;
    }

    function mintNFT(address recipient, string memory tokenURI) public onlyMinters returns (uint256) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);
        return newItemId;
    }
}