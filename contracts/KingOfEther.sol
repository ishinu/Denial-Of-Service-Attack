// SPDX-License-Identifier:MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract KingOfEther is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    address public king;
    uint public topDeposit;

    function initialize() initializer public{
        __Ownable_init();
      __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(address) internal override onlyOwner {}

    function claimOwnership() public payable{
        require(msg.value>topDeposit);

        (bool sent,) = king.call{value:topDeposit}("");
        require(sent,"Failed to send deposited amount.");

        king = msg.sender;
        topDeposit = msg.value;
    }
}
