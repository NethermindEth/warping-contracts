# warping-contracts
Testing optimized experimental contracts from the somlate library:

https://github.com/transmissions11/solmate

solmate: 

    -🟡Tokens
        -🟡ERC20.sol:
            -🟢solmate ERC20 works
            -🔴fails with EIP-2612 STORAGE (commented out for now)
        -🟡WETH.sol:
            -🟢can work as a generic ERC-20 that doesn't use msg.value
            -🔴depends on ether
                -deposit{value:msg.value}
                -withdraw(amount)
                -receive and fallback (not supported yet)
                -utils/SafeTransferLib.sol uses:
                    -call
                    -gas
        -🟡ERC721.sol:
            -🟡need to test more
        -🟡ERC1155.sol:
            -🟡need to test more