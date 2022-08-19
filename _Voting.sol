pragma solidity >=0.7.0 < 0.9.0;

contract Ballot{

    struct vote{
        address voterAddress;
        bool choice;
    }

    struct voter{
        string voterName;
        bool voted;
    }

    uint private countResult = 0;
    uint public finalResult = 0;
    uint public totalVoter = 0;
    uint public totalVote =0;

    address public BallotOfficialAddress;
    string public ballotOfficialName;
    string public proposal;

    mapping(uint => vote) private votes;
    mapping(address => voter) public voterRegister;

    enum State{ Created, Voting, Ended }
    State public state;

    constructor(){
        
    }
}