// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

interface IERC721 {
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
}

interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

contract bulkSenderERC721 { 

    function bulkTransfer(address nftAddress, address[] calldata toList, uint256[] calldata tokenIds) external {
        for (uint256 i = 0; i < toList.length;) {
            IERC721(nftAddress).safeTransferFrom(msg.sender, toList[i], tokenIds[i]);
            unchecked { i += 1; }
        }
    }

}

contract burnERC721 is IERC721Receiver {

    function onERC721Received(address, address, uint256, bytes memory) public virtual override returns (bytes4) {
        return this.onERC721Received.selector;
    }

}