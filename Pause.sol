// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Paused{
    mapping(address=>uint) public balances;
   
   // adding the paused functionality
    bool private _paused; 

    address public owner;
    constructor(){
        owner=msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender==owner,"only owner can call it");
        _;
    }
    receive() external payable{}
    function addfunds() public payable{
          balances[msg.sender]+=msg.value;
    }
    
    function paused() public onlyOwner {
        require(!_paused);
        _paused=true;
    }

    function unpaused() public onlyOwner {
        require(_paused);
        _paused=false;
    }

    modifier whenNotPaused() {
         require(!_paused);
         _;
    }

    modifier whenpaused(){
        require(_paused);
        _;
    }

    function withdrawMoney() public payable whenNotPaused{
         require(balances[msg.sender]>0,"you must deposit first.");
         uint amounttowithdraw=balances[msg.sender];
         balances[msg.sender]=0;
         payable(msg.sender).transfer(amounttowithdraw);
    }   

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    

}