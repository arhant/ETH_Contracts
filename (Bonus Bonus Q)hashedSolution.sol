pragma solidity ^0.4.0;


contract PayableContract{

    bool success = false;
    bytes32 length_Ndigits = 0x880de8116b3dfac28e9ff528a9fef1d1e0a51449c1addce011ffec1f302992b6; // supposse answer is 40. This is hashed value for 40.
    mapping (address => uint) private addresses;
    uint reward = uint(1)/uint(10);
    string istransfer = "No transfer till now, please answer";
    
    event Update(string _msg, uint _amount);
    
    function PayableContract() payable{
        
    }
    
    modifier ifIssuer(){
       if(addresses[msg.sender] > 0){
            istransfer = "Seems you have already answered the question!";
            success = false;
            revert(istransfer);
        }
        if(success){
            istransfer = "Seems someone already answered this question!";
            success = false;
            revert(istransfer);
        }
        else{
            addresses[msg.sender] += 1;
            _;
        }
        
    }
    

    function receiveFunds() payable {
        Update("User deposited some money", msg.value);
    }
    
    
    function sendFunds(uint amount, address senderID) ifIssuer internal returns(string){
        if(senderID.send(amount)){
            success = true;
            istransfer = "amount added to your account : 0.1";
        }else{
            success = false;
            revert();
        }
        return (istransfer);
    }
    
    
    function setProof(string newWord)  payable{
        bytes32 word = keccak256(newWord); 
        if(bytes32(word).length == bytes32(length_Ndigits).length) {
            if(word == length_Ndigits){
                sendFunds(reward, msg.sender);
              }
        } else {
            success = false;
            istransfer = "Not a valid response";
        }
    }
    
    
    function getInfo() constant returns(string){
        return istransfer;
    }
      
        
    function getBalance() constant internal ifIssuer returns(uint){
        return this.balance;
    }
}