pragma solidity ^0.8.4;
contract Time {
    uint256 public createTime;

    // function Time() public {
    //     createTime = now;
    // }

      constructor() {
       createTime = block.timestamp;

    }
}

