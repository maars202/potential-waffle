// pragma solidity ^0.8.4;


// contract Lottery {
//     address alarm; // set by some other mechanism.

//     function beginLottery() public {
//         // ... // Do whatever setup needs to take place.

//         // Now we schedule the picking of the winner.

//         bytes4 sig = bytes4(keccak256("pickWinner()"));
//         // approximately 24 hours from now
//         uint targetBlock = block.number + 5760;
//         // 0x1991313 is the ABI signature computed from `bytes4(sha3("scheduleCall(...)"))`.
//         // alarm.call(0x1991313, address(this), sig, targetBlock);
//         alarm.call(sig);
//     }

//     function pickWinner() public {
//         // ...
//     }
// }