pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract Account {
  // Post data structure
  struct Post {
    string message;
    uint timestamp;
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

  // Create a post as an owner
  function createPost(string memory message) public isOwner() {
    require(bytes(message).length <= 160, "Message too long");
    posts[postCount].message = message;
    posts[postCount].timestamp = block.timestamp;
    postCount++;
  }

  // Get a specific post
  function getPost(uint postId) public view returns (string memory message, uint timestamp) {
    require(postId < postCount, "Invalid postId");
    message = posts[postId].message;
    timestamp = posts[postId].timestamp;
  }

  //
  // Fancy new way to do this? Problem is the kv pairs lose the key names
  // ¯\_(ツ)_/¯
  //    _  __          __  _  ___    __
  //   | |/_/__  ___  / / | |/_(_)__/ /__
  //  _>  </ _ \/ _ \/ / _>  </ / _  (_-<
  // /_/|_|\___/\___/_/ /_/|_/_/\_,_/___/
  //
  // function getPosts() public view returns (Post[] memory) {
  //   Post[] memory _posts = new Post[](postCount);
  //   for(uint i = 0; i < postCount; i++) {
  //     Post storage post = posts[i];
  //     _posts[i] = post;
  //   }

  //   return _posts;
  // }

  // Old school less "error prone?" way. I really don't get it right now.
  // Honestly this one makes more sense since I can reduce them into a single array.
  function getPosts() public view returns (string[] memory messages, uint[] memory timestamps) {
    messages = new string[](postCount);
    timestamps = new uint[](postCount);

    for(uint i = 0; i < postCount; i++) {
      messages[i] = posts[i].message;
      timestamps[i] = posts[i].timestamp;
    }

    return (messages, timestamps);
  }
}