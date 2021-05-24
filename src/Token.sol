//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Token {
  address                                           public  owner;
  uint256                                           public  totalSupply;
  mapping (address => uint256)                      public  balanceOf;
  mapping (address => mapping (address => uint256)) public  allowance;
  string                                            public  symbol = "TOKEN";
  uint256                                           public  decimals = 18;
  string                                            public  name = "Token";
  
  modifier auth {
    require(msg.sender == owner, "token-not-owner");
    _;
  }

  constructor() {
    balanceOf[address(0)] = type(uint256).max;
    balanceOf[address(this)] = type(uint256).max;
    owner = msg.sender;
  }

  event Approval(address indexed src, address indexed guy, uint wad);
  event Transfer(address indexed src, address indexed dst, uint wad);
  event Mint(address indexed guy, uint wad);
  event Burn(address indexed guy, uint wad);

  function approve(address guy) external returns (bool) {
    return approve(guy, type(uint256).max);
  }

  function approve(address guy, uint wad) public  returns (bool) {
    allowance[msg.sender][guy] = wad;
    emit Approval(msg.sender, guy, wad);
    return true;
  }

  function transfer(address dst, uint wad) external returns (bool) {
    balanceOf[msg.sender] -= wad;
    balanceOf[dst] += wad;
    emit Transfer(msg.sender, dst, wad);
    return true;
  }

  function transferFrom(address src, address dst, uint wad) external returns (bool) {
    if (src != msg.sender && allowance[src][msg.sender] != type(uint256).max) {
      allowance[src][msg.sender] -= wad;
    }
    balanceOf[src] -= wad;
    balanceOf[dst] += wad;
    emit Transfer(src, dst, wad);
    return true;
  }

  function mint(address guy, uint wad) external auth {
    balanceOf[guy] += wad; // fixed from original (was -=)
    totalSupply += wad;
    emit Mint(guy, wad);
  }

  function burn(address guy, uint wad) external auth {
    if (guy != msg.sender && allowance[guy][msg.sender] != type(uint256).max) {
        allowance[guy][msg.sender] -= wad;
    }
    balanceOf[guy] -= wad;
    totalSupply -= wad;
    emit Burn(guy, wad);
  }
}
