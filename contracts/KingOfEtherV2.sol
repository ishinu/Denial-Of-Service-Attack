// SPDX-License-Identifier:MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract KingOfEtherV2 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    address public king;
    uint public topDeposit;
    mapping(address=>uint) public balances;

    function initialize() initializer public{
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(address) internal override onlyOwner {}

    function claimOwnership() public payable{
        require(msg.value>topDeposit);
        balances[king] += topDeposit;
        king = msg.sender;
        topDeposit = msg.value;
    }

    function withdraw() public payable{
        require(balances[msg.sender]>0);
        uint amount = balances[msg.sender];
        balances[msg.sender]= 0;

        (bool sent,) = msg.sender.call{value:amount}("");
        require(sent,"Failed to send deposited amount.");
    }
}
