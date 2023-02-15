# **Warping Origin Dollar ( OUSD ) protocol**
## Background
Origin Dollar (OUSD) is an ERC-20 compliant token for the Ethereum network. 
OUSD is a stable currency that is backed 1:1 by other stablecoins like USDT, USDC and DAI. As a result, 1 OUSD should always be very close to 1 USD in value.
<hr>
OUSD protocol is mainly composed of 3 contracts : OUSD, Vault and Strategy.
the strategy serves as yield farming for OUSD holders and DAO members can vote on new proposals about how to allocate their funds. 1 strategy for example is AAVE.

<hr>

## ** Changes made **

1. OppenZeppelin/Context -> lib/EasyContext

deleted this line as it's not supported in warp
```javascript
    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
```

2. OppenZeppelin/ERC20 , Ownable -> updated to import EasyContext

3. OppenZeppelin/SafeMath -> deleted functions with dynamic error message as this is not supported in warp

```javascript
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

```

