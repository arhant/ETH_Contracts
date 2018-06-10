pragma solidity ^0.4.0;

import "github.com/willitscale/solidity-util/lib/Strings.sol";

contract PayableContract{
    
    using Strings for string;
    bool success = false;
    string private length = "40"; //length of distinct 100 digits number
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
        } else{
            addresses[msg.sender] += 1;
            _;
        }
    }
    

    function receiveFunds() payable {
        Update("Money Deposited ", msg.value);
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
                if(newWord.compareTo(length)){
                     sendFunds(reward, msg.sender);
                }else {
            success = false;
            istransfer = "Not a valid response";
        }
        Update("User got money ", reward);
    }
    
    
    function getInfo() constant returns(string){
        return istransfer;
    }
      
        
    function getBalance() constant internal ifIssuer returns(uint){
        return this.balance;
    }
}