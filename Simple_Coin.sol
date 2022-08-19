//create a coin send and recieve check balances..

pragma solidity >=0.7.0 <0.9.0;

contract Coin {
    address public minter;
    mapping(address=>uint) public balances;

    //events: 
    event Send(address from,address to,uint amount);

    constructor(){
        minter = msg.sender;
    }

    function mint(address reciever, uint amount) public {
        require(msg.sender == minter);
        require(amount < 1e60);

        balances[reciever] += amount;
    } 

    function send(address reciever, uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -=amount;
        balances[reciever] +=amount;
        //trigger the event
        emit Send(msg.sender,reciever,amount);
    }
}