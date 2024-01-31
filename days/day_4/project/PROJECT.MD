# Project 4 - The collective voice

<img src="../../../assets/day_4/project/cover.png"  style="width: 100%;"/>

## 💭 Story

Walking through the Academy, you hear a mix of different sounds, like a music. Following the sound, you enter in a new room - filled with students.

Inside, students are grouped together, each singing a different note or using a different instrument, yet harmoniously contributing to an enchanting melody.

The guiding AI floats by, whispering, "_Just as in music, a DAO should translate individual voices into harmonious decisions._"

It's time to orchestrate your DAO's voting system, letting every member strike their note.

## 🎯 Mission

Your mission, should you choose to accept it, is to create and implement a voting system.

> Specifically, in this level, we will create a voting mechanism for changing the DAO's manifesto or adding goals as defined in Level 1. This level relies on variables and functions implemented in previous levels, so it's advisable to complete those first if you haven't already.

## 👨‍🏫 Requirements

The voting system should respect the following requirements:

- Only allow members of the DAO to vote and create proposals.
- The voting power of each member should be equal to the number of tokens they hold.
- Creating a proposal should require to burn 1 token.
- A member can only vote once per proposal.
- Everytime a member votes, the score of the proposal is updated. Depending on whether or not the member voted for or against the proposal, the score should be increased or decreased by the member's voting power. For instance, if a member with 10 tokens votes for a proposal, the score should be increased by 10. If the same member votes against the proposal, the score should be decreased by 10.
- A proposal is automatically approved if the score reaches 100 or more. A proposal is automatically rejected if the score reaches -100 or less. Otherwise the proposal is still open to voting.
- Any approved proposal should be automatically executed by the DAO.

## ✏️ Tasks

To help you get started we've defined different types in [types.mo](./types.mo)

> Make sure to not modify the types defined in this file. Any modification of those types or the interface of the canister will result in a failing test.

1. Create a datastructure to store the proposals.
2. Implement the `createProposal` function. If the proposal is successfully created, the function should return the id of the proposal.
3. Implement the `getProposal` function.
4. Implement the `voteProposal` function.
5. Implement the `getAllProposals` function.

## 📺 Interface

At the end of this level, your canister should implement the following interface:

```motoko
actor {
  createProposal : (content : ProposalContent) -> async Result<ProposalId, Text>;
  getProposal : (id : ProposalId) -> async ?Proposal;
  voteProposal : (id : ProposalId, yesOrNo : Bool) -> async Result<(), Text>;
  getAllProposals : () -> async [Proposal];
}
```
