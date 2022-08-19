//send money to all the winners

pragma solidity >=0.7.0 <0.9.0;

contract myContract{

    uint public myUint = 1;
    int public myInt = -1;
    string public myString = "MyString";
    bool public myBool = true;
    //constant --> never be changed 

    uint public playerCount = 0;
    mapping(address => Player) public players;

    uint public pot = 0;

    address public dealer;

    Player[] public playersInGame;
    //cant loop through a mapping object

    enum Level{Novice,Intermediate,Advanced}

    constructor(){
        dealer = msg.sender;
    }

    struct Player{
        //have to specify how this wll b saved
        address playerAddress;
        string firstName;
        string LastName;
        Level playerLevel;
        uint createdTime;
    }

    function addPlayer(string memory firstName, string memory LastName) private {
        Player memory newPlayer = Player(msg.sender,firstName,LastName,Level.Novice,block.timestamp);
        players[msg.sender] = newPlayer;
        playersInGame.push(newPlayer);
    }

    function getPlayerLevel(address playerAddress) public view returns(Level){
        return players[playerAddress].playerLevel;
    }

    //allows new players to join game
    function joinGame(string memory firstName, string memory LastName) payable public{
        require(msg.value == 25 ether , "Joining fee is 25 Ether");
        if(payable(dealer).send(msg.value)){
            addPlayer(firstName,LastName);
            playerCount += 1;
            pot += 25;
        }
    }

    //payout the winners
    function payoutWinners(address loserAddress) payable public {
        require(msg.sender == dealer , "Only dealer can payout the winners");
        require(msg.value == pot * (1 ether));

        uint payoutPerWinner = msg.value / (playerCount -1);
        for(uint i=0; i<playersInGame.length; i++){
            address currentPlayerAddress = playersInGame[i].playerAddress;
            if(currentPlayerAddress != loserAddress){
                payable(currentPlayerAddress).transfer(payoutPerWinner);
            }
        }
    }

}