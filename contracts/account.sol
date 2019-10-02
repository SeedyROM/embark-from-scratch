pragma solidity ^0.5.0;

contract Account {
  struct Post {
    uint timestamp;
    string message;
  }

  uint public postCount;
  address payable owner = msg.sender;
  mapping(uint => Post) posts;

  modifier isOwner() {
    require(owner == msg.sender, "Not the owner");
    _;
  }

  constructor() public {
    postCount = 0;
  }

  function post(string memory message) public isOwner() {
    require(bytes(message).length <= 160, "Message too long");
    posts[postCount].timestamp = block.timestamp;
    posts[postCount].message = message;
    postCount++;
  }

  function getPost(uint postId) public view returns (string memory message, uint timestamp) {
    require(postId < postCount, "Invalid postId");
    message = posts[postId].message;
    timestamp = posts[postId].timestamp;
  }
}