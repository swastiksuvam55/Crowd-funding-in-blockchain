// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract Crowdfunding {
    // The address of the project owner
     address payable public owner;

    // The total amount of funds raised
    uint public totalFunds;

    // The goal amount of funds to be raised
    uint public goal;

    // A mapping from addresses to the amount of funds contributed by each contributor
    mapping(address => uint) public contributions;

    // An event that is triggered when a new contribution is made
    event NewContribution(address contributor, uint amount);

    // The constructor function, which is called when the contract is deployed
    constructor(uint _goal) {
        owner = payable(msg.sender);
        goal = _goal;
    }

    // A function that allows contributors to contribute funds to the campaign
    function contribute() public payable {
        require(msg.value > 0, "Cannot contribute 0 or negative value");

        // Update the total funds raised and the contribution for the current contributor
        totalFunds += msg.value;
        contributions[msg.sender] += msg.value;

        // Trigger the NewContribution event
        emit NewContribution(msg.sender, msg.value);
    }

    // A function that allows the owner to withdraw the funds if the goal has been reached
    function withdraw() public {
        require(totalFunds >= goal, "Goal has not been reached");
        require(msg.sender == owner, "Only the owner can withdraw funds");

        // Send the funds to the owner
        owner.transfer(totalFunds);
    }
}
