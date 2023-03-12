// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "./chainlink/contracts/src/v0_8/ChainlinkClient.sol"; //Rename file path to remove "." to help Warp transpiler.

contract ATestnetConsumerGoerli is ChainlinkClient {

    using Chainlink for Chainlink.Request;

    address constant oracleGoerli = address(0xCC79157eb46F5624204f47AB42b3906cAA40eaB7); //Warp wrapper;
    // string constant jobIdGoerli = "ca98366cc7314957b8c012c72f05aeeb";
    bytes32 constant jobIdGoerliBytes32 = 0x6361393833363663633733313439353762386330313263373266303561656562;
    uint256 public constant ORACLE_PAYMENT = (1 * LINK_DIVISIBILITY) / 10; // 0.1 * 10**18 (0.1 LINK)
    uint256 public currentPrice;

    event RequestEthereumPriceFulfilled(
        bytes32 indexed requestId,
        uint256 indexed price
    );

    constructor() {
        setChainlinkToken(address(0x326C977E6efc84E512bB9C30f76E30c160eD06FB)); //Address type wrapper for warp. 
    }

    function requestEthereumPrice() public {
        Chainlink.Request memory req = buildChainlinkRequest(
            // stringToBytes32(jobIdGoerli),
            jobIdGoerliBytes32,
            address(this),
            this.fulfillEthereumPrice.selector
        );
        req.add(
            "get",
            "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD"
        );
        req.add("path", "USD");
        req.addInt("times", 100);
        sendChainlinkRequestTo(oracleGoerli, req, ORACLE_PAYMENT);
    }

    function fulfillEthereumPrice(
        bytes32 _requestId,
        uint256 _price
    ) public recordChainlinkFulfillment(_requestId) {
        emit RequestEthereumPriceFulfilled(_requestId, _price);
        currentPrice = _price;
    }

    // function stringToBytes32(
    //     string memory source
    // ) private pure returns (bytes32 result) {
    //     bytes memory tempEmptyStringTest = bytes(source);
    //     if (tempEmptyStringTest.length == 0) {
    //         return 0x0;
    //     }

    //     assembly {
    //         // solhint-disable-line no-inline-assembly
    //         result := mload(add(source, 32))
    //     }
    // }
}