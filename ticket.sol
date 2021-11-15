// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

contract Tiket {
    uint256 ticketPrice = 0.01 ether;
    address owner;
    mapping (address => uint256) public ticketHolders;
    
    constructor() {
        owner = msg.sender;
    }
    
    function buyTickets(address _user, uint256 _amount) payable public {
        require(msg.value >= ticketPrice * _amount);
        addTicket(_user, _amount);
    }
    
    function useTickets(address _user, uint256 _amount) public {
        subTicket(_user, _amount);
    }
    
    function addTicket(address _user, uint256 _amount) internal {
        ticketHolders[_user] = ticketHolders[_user] + _amount;
    }
    
    function subTicket(address _user, uint256 _amount) internal {
        require(ticketHolders[_user] >= _amount, "You do not have enough tikets.");
        ticketHolders[_user] = ticketHolders[_user] - _amount;
    }
    
    function withdraw() public {
        require(msg.sender == owner, "You are not owner");
        (bool success, ) = payable(owner).call{value: address(this).balance}("");
        require(success);
    }
}
