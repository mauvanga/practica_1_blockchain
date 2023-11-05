// SPDX-License-Identifier: Unlicenced
pragma solidity 0.8.18;
contract TokenContract {

 address public owner;
 struct Receivers {
 string name;
 uint256 tokens;
 }
 mapping(address => Receivers) public users;

 modifier onlyOwner(){
 require(msg.sender == owner);
  _;
 }

 constructor(){
 owner = msg.sender;
 users[owner].tokens = 100;
 }

 function double(uint _value) public pure returns (uint){
 return _value*2;
 }

 function register(string memory _name) public{
 users[msg.sender].name = _name;
 }

 function giveToken(address _receiver, uint256 _amount) onlyOwner public{
 require(users[owner].tokens >= _amount);
 users[owner].tokens -= _amount;
 users[_receiver].tokens += _amount;
 }

 function comprarToken(uint256 _amount) public payable{
        require(msg.value >= _amount * 5, "Ether insuficiente para comprar tokens");
        require(users[owner].tokens >= _amount, "Tokens insuficientes disponibles");

        uint256 cost = _amount * 5;
        users[owner].tokens -= _amount * 5;
        users[msg.sender].tokens += _amount;
        
        payable(owner).transfer(cost);
 
 }

  function getCantidadEther() public view returns (uint256) {
        return address(this).balance;
    }
}
