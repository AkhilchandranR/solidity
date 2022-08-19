pragma solidity >=0.7.0 <0.9.0;

contract SimpleAuction{
    //parameters of auction
    address payable public beneficiary;
    uint public auctionEndTime;

    //current state of the auction
    address public highestBidder;
    uint public highestBid;

    mapping(address => uint) public pendingReturns;
    bool ended = false;

    event highestBidIncrease(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    constructor(uint _biddingTime, address payable _beneficiary){
        beneficiary = _beneficiary;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    function bid() public payable{
        if(block.timestamp > auctionEndTime){
            revert("The auction has already ended !!!");
        }
        if(msg.value <= highestBid){
            revert("Already a higher or equal bid exists");
        }

        if(highestBid != 0){
            pendingReturns[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
        emit highestBidIncrease(msg.sender,msg.value);
    }

    function withdraw() public returns(bool){
        uint amount = pendingReturns[msg.sender];
        if(amount > 0){
            pendingReturns[msg.sender] = 0;

            if(!payable(msg.sender).send(amount)){
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }

    function auctionEnd() public {
        if(block.timestamp < auctionEndTime) {
            revert("Auction has not ended yet");
        }
        if(ended){
            revert("auction ended already called");
        }

        ended = true;
        emit AuctionEnded(highestBidder,highestBid);

        beneficiary.transfer(highestBid);
    }
}