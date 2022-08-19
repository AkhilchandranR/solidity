pragma solidity >=0.7.0 <0.9.0;

contract Coin {
    address public minter;
    mapping(address=>uint) public balances;

    //modifiers allow us to change the behavior of the function
    //organise our code and reuseable in other functions and is inheritable...
    modifier onlyOwner {
        require(msg.sender == minter, "Only minter can call this function");
        _;
    }

    modifier amountGreater (uint amount){
        require(amount < 1e60);
        _;
    }

    modifier checkBalance (uint amount) {
        require(amount <= balances[msg.sender], "Insufficient balance");
        _;
    }

    //events: 
    event Send(address from,address to,uint amount);

    constructor(){
        minter = msg.sender;
    }

    function mint(address reciever, uint amount) public onlyOwner amountGreater(amount){

        balances[reciever] += amount;
    } 

    function send(address reciever, uint amount) public checkBalance(amount){
        balances[msg.sender] -=amount;
        balances[reciever] +=amount;
        //trigger the event
        emit Send(msg.sender,reciever,amount);
    }
}