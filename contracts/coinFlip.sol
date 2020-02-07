import "./Ownable.sol";
import"./provableAPI.sol";

pragma solidity 0.5.2;

contract CoinFlip is Ownable{

  //uint256 NUM_RANDOM_BYTES_REQUESTED = 1;

  event balanceUpdated (bool done);
//  event LogNewProvableQuery (string queryRequested);
  //event generatedRandomNumber (uint256 randomNumber);

  bool done = true;

  modifier costs (uint cost){
      require (msg.value >= cost,"Min bet is 0.5 Ether");
      _;
  }

  struct User {
    bytes32 id;
    address playerAddress;
    uint choice;
  }

  mapping (bytes32 => User) private player;

  function random () public view returns (uint){
    return now % 2;
  }

  function flip (uint decision) public payable costs (5000000000000000 wei){
    require (getContractValue () >= msg.value*2, "Contract does not have enough funds");
    uint bet = msg.value;
    //update(msg.sender, decision);
    }

  function getContractValue () public view returns (uint){
    return address(this).balance;
  }

  function loadUpContract () public payable onlyOwner{
    emit balanceUpdated(done);
  }

  function withdrawalAll () public onlyOwner {
    msg.sender.transfer(getContractValue());
    assert(getContractValue()==0);
  }

/*  function update(address cstAdss, uint cstDcsn) payable public {
    uint256 QUERY_EXECUTION_DELAY = 0;
    uint256 GAS_FOR_CALLBACK =200000;
    bytes32 query_id = provable_newRandomDSQuery(QUERY_EXECUTION_DELAY, NUM_RANDOM_BYTES_REQUESTED, GAS_FOR_CALLBACK);

    User memory newUser; //Popolo la struct;
    newUser.playerAddress = cstAdss; //Popolo la struct;
    newUser.choice = cstDcsn; //Popolo la struct;
    player[query_id] = newUser; //Popolo la struct;

    emit LogNewProvableQuery ("Provable query was sent, waiting for the callback");
  }

  function __callback(bytes32 _queryId, string memory _result, bytes memory _proof) public {
    require (msg.sender == provable_cbAddress());

    uint256 randomNumber = uint256(keccak256(abi.encodePacked(_result)))%2;
    emit generatedRandomNumber (randomNumber); */
  }
