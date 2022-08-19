//checking for created time 
//working with time on blockchain..

pragma solidity >=0.7.0 <0.9.0;

contract myContract{

    uint public myUint = 1;
    int public myInt = -1;
    string public myString = "MyString";
    bool public myBool = true;
    //constant --> never be changed 

    uint public playerCount = 0;
    mapping(address => Player) public players;

    enum Level{Novice,Intermediate,Advanced}

    struct Player{
        //have to specify how this wll b saved
        address playerAddress;
        string firstName;
        string LastName;
        Level playerLevel;
        //time
        uint createdTime;
    }

    function addPlayer(string memory firstName, string memory LastName) public {
        players[msg.sender] = Player(msg.sender,firstName,LastName,Level.Novice,block.timestamp);
        playerCount += 1;
    }

    function getPlayerLevel(address playerAddress) public view returns(Level){

        Player storage player = players[playerAddress];
        return player.playerLevel;

    }

    function changePlayerLevel(address playerAddress) public {
        Player storage player = players[playerAddress];
        if(block.timestamp >= player.createdTime + 20){
            player.playerLevel = Level.Intermediate;
        }
    }

}