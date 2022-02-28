import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";

contract FrensToken is
    Ownable,
    ERC20,
    ERC20Detailed("Frens Token", "FRENS", 18)
{
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
        payble(receiverAddress).transfer(this.balance);
    }
}
