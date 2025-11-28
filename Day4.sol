//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract AuctionHouse{
     address public owner;
     string public item;
     uint public auctionEndTime;
     address private highestBidder;
     uint private highestBid;
     bool public ended;

     mapping(address=>uint) public bids;
     address[] public bidders;

    constructor(string memory _item, uint _biddingTime){
        owner = msg.sender;
        item = _item;
        auctionEndTime= block.timestamp + _biddingTime;
    }

    function bid(uint _amount) external {
        //check whether bidding is on or ended : use require statement
        require(block.timestamp < auctionEndTime,"Auction has been ended ");
        //check bidding amount by the user, it must be greater than 0
        require(_amount>0,"Bid amount must be greater than 0");
        //check bids must be greater than the declare amount by owner
        require(_amount>bids[msg.sender],"Amount must be greater than declare by owner");
         
        if(bids[msg.sender]==0){
            bidders.push(msg.sender);
        } 

        bids[msg.sender] = _amount;
        if(_amount > highestBid){
            highestBid = _amount;
            highestBidder = msg.sender;
        }
    }

    function endAuction() external{
        require(block.timestamp >= auctionEndTime,"Auction has not ended yet");
        require(!ended,"Auction end has already been called");
        ended = true;
    }

    function getWinner() external view returns(address,uint){
      require(ended,"Auction has been ended");
      return(highestBidder,highestBid);
    }

    function getAllBidders() external view returns(address[] memory){
        return(bidders);
    }

}