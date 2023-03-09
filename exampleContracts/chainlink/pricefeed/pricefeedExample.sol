// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

// AggregatorV3Interface contract from: https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

interface AggregatorV3Interface {
    
    function decimals() external view returns (uint8);

    function description() external view returns (string memory);

    function version() external view returns (uint256);

    function getRoundData(uint80 _roundId)
        external
        view
        returns (
        uint80 roundId,
        int256 answer,
        uint256 startedAt,
        uint256 updatedAt,
        uint80 answeredInRound
        );

    function latestRoundData()
        external
        view
        returns (
        uint80 roundId,
        int256 answer,
        uint256 startedAt,
        uint256 updatedAt,
        uint80 answeredInRound
        );
}

// Pricefeed example from: https://docs.chain.link/data-feeds/using-data-feeds/#examine-the-sample-contract

contract PriceConsumerV3 {

    /**
     * Network: Sepolia
     * Aggregator: BTC/USD
     * Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
     */

    AggregatorV3Interface internal priceFeed = AggregatorV3Interface(address(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43)); //Added address type wrapper to resolve Starknet type error.

    function getLatestPrice() public view returns (int) {
        (
            /* uint80 roundID */,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }
}
