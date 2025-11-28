//SPDX-License-Identifier:MIT

pragma solidity >=0.8.0;

contract SaveMyName{
   string name;
   string bio;
   
   //it is modifying the blockchain , hence cast gas fee
   function add(string memory _name, string memory _bio) public {
    name = _name;
    bio = _bio;
   }
   //this is a view function,it is not modifying the blockchain , Hence 0 gas fee.
   function retireive() public view returns(string memory,string memory){
    return (name,bio);
   }
   
    //it is modifying the blockchain , hence cast gas fee
   function saveAndRetreive(string memory _name,string memory _bio) public returns(string memory,string memory){
    name = _name;//this is not a good way to write a function, bcz even if user want to retreive the data, then also it will cost gas.
    bio = _bio;
    return (name,bio);
   }
}