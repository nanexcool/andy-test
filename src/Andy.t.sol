pragma solidity ^0.6.7;

import "ds-test/test.sol";

import "./Andy.sol";

contract AndyTest is DSTest {
    Andy andy;

    function setUp() public {
        andy = new Andy();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
