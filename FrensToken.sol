// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

pragma solidity ^0.8.12;

contract FrensToken is Ownable, ERC20("Frens Token", "FRENS") {
    address receiverAddress = 0x165CD37b4C644C2921454429E7F9358d18A45e14;
    bool donationsOpen = true;

    function changeDonationsState(bool state) public onlyOwner {
        donationsOpen = state;
    }

    function changeReceiverAddress(address newAddress) public onlyOwner {
        receiverAddress = newAddress;
    }

    function donateETH() public payable {
        require(donationsOpen, "Donations aren't open.");
        _mint(msg.sender, msg.value);
    }

    function sendETHToReceiver() public {
        payable(receiverAddress).transfer(address(this).balance);
    }
}
