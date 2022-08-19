//storing something using smart contracts...
pragma solidity >=0.4.16 <0.9.0;

contract Storage{
    uint storedData;

    function set(uint x) public {
        storedData = x;
    }

    function get() public view returns(uint){
        return storedData;
    }
}

//msg
/*
msg.data --> hash of the info send to the smart contract
msg.sig --> signature of function with data
msg.value --> value sent to the contract
msg.sender --> sender address person interacting with the contract
msg.gas --> gas fee
tx.origin --> sender in case of one contract communicating with another
*/

//block
/** 
block.timestamp --> current block time (epoch time)
block.chainid --> current blockchain id , verify from forks
block.coinbase --> returns address of current block's miner
block.gaslimit --> uint maximum amt of gas fees, limits transactions
block.number --> current number of block

blockhash() --> hash of the current block
gasleft() --> count how much gas left/used
*/