//SPDX-License-Identifier:MIT

pragma solidity >=0.8.0;

contract PollStation{
   
   //since we need prople can vote
   //for this, we must have a list of candidate
   //therefore use array
   string[] public candidateNames;
   mapping(string => uint) public voteCount;//whenever you need to link 2 things, or you want to access 2nd thing by using 1st as a paramter

   function addCandidateName(string memory _candidateNames) public {
      candidateNames.push(_candidateNames);
      voteCount[_candidateNames] = 0;
        
   }
/*
   function vote(string memory _candidateNames) public {
   // require(_candidateNames != candidateNames, "No candidate is available with this name");
    require(candidateExists(_candidateNames), "Candidate does not exist");
    voteCount[_candidateNames] ++;
   }
 */ 
    function vote(string memory _candidateNames) public {
        require(candidateExists(_candidateNames), "Candidate does not exist");
        voteCount[_candidateNames] ++;
    }

    function candidateExists(string memory name) internal view returns (bool) {
        for (uint i = 0; i < candidateNames.length; i++) {
            if (keccak256(bytes(candidateNames[i])) == keccak256(bytes(name))) {
                return true;
            }
        }
        return false;
    }
   function getCandidateName() public returns(string[] memory){
    return candidateNames;
   }

   function getVoteCount(string memory _candidateNames) public returns(uint){
     return voteCount[_candidateNames];//this will give uint value of 
   }
   //Additional things can be added
   //add admin permission, so that only admin can add candidates
   //candidateName must match with existing candidate
}