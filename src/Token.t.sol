//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";

import "./Token.sol";

contract TokenTest is DSTest {
    Token token;

    function setUp() public {
        token = new Token();
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }

    function prove_balance(address usr, uint amt) public {
        // can't mint/transfer to 0 or token address
        if (usr == address(0)) return;
        if (usr == address(token)) return;
        assertEq(0, token.balanceOf(usr));
        token.mint(usr, amt);
        assertEq(amt, token.balanceOf(usr));
    }
}
