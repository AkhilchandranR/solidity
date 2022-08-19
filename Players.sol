//teach us to create an entity ie player here 
//---create their record and access it 
//dirrent data types of simple as well as compount as well as user defined ones


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
    }

    function addPlayer(string memory firstName, string memory LastName) public {
        players[msg.sender] = Player(msg.sender,firstName,LastName,Level.Novice);
        playerCount += 1;
    }

    function getPlayerLevel(address playerAddress) public view returns(Level){
        return players[playerAddress].playerLevel;
    }

}