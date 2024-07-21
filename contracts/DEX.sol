// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DEX { 
    address public owner;
    mapping(address => mapping(address => uint256)) public userBalances;

    // Event to log ownership transfer
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor(address _owner) {
        owner = _owner; // Set the initial owner as passed during deployment
        emit OwnershipTransferred(address(0), owner);
    }

    function deposit(address token, uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        userBalances[token][msg.sender] += amount;
    }

    function withdraw(address token, uint256 amount) public {
        require(userBalances[token][msg.sender] >= amount, "Insufficient balance");
        userBalances[token][msg.sender] -= amount;
    }

    function swap(address tokenSold, address tokenBought, uint256 amountSold, uint256 amountBought) public {
        require(userBalances[tokenSold][msg.sender] >= amountSold, "Insufficient balance for token sold");
        require(userBalances[tokenBought][address(this)] >= amountBought, "Insufficient liquidity for token bought");

        userBalances[tokenSold][msg.sender] -= amountSold;
        userBalances[tokenBought][msg.sender] += amountBought;
    }

    function buy(address token, uint256 amount) public payable {
        require(msg.value == amount, "Sent ETH must match amount");
        userBalances[token][msg.sender] += amount;
    }

    function sell(address token, uint256 amount) public {
        require(userBalances[token][msg.sender] >= amount, "Insufficient balance");
        userBalances[token][msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // Function to transfer ownership to a new address
    function transferOwnership(address newOwner) public {
        require(msg.sender == owner, "Only the owner can transfer ownership");
        require(newOwner != address(0), "Invalid new owner");
        address previousOwner = owner;
        owner = newOwner;
        emit OwnershipTransferred(previousOwner, newOwner);
    }
}

