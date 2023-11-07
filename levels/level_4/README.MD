# Level 4 - The collective voice 
## Introduction
Walking through the Academy, you hear a mix of different sounds, like a music. Following the sound, you come to a big area. 
Inside, students are grouped together, each singing a different note or using  a different instrument, yet harmoniously contributing to an enchanting melody. The guiding AI floats by, whispering, "_Just as in music, a DAO should translate individual voices into harmonious decisions._" 

You're about to learn that in a DAO, making choices isn't about the loudest voice, but about ensuring every voice contributes to the collective song. It's time to orchestrate your DAO's voting system, letting every member strike their note. 
## 🎯 Mission
Your mission, should you choose to accept it, is to implement a voting system for your DAO. 

_Setting up a voting system with different types of proposals is a challenging endeavour. Today, we're only going to set up a way for everyone to vote on changing the DAO's manifesto that we have defined in Level 1. That's our focus for the day._

### Task 1 : Define the `Status` and `Proposal` types
Implement the `Status` and `Proposal` types. Here's what you need to know:
- `Status`: Represents the status of a proposal. It can be either `Open`, `Accepted` or `Rejected` and is defined using a `Variant` type.
- `Proposal`: Represents a proposal. It is defined using a `Record` type and has the following fields:
    - `id`: A `Nat` representing the unique identifier of the proposal.
    - `status`: A `Status` representing the status of the proposal.
    - `manifest`: A `Text` representing the new manifesto.
    - `votes`: A `Int` representing the value of the votes received by the proposal. (This value can be negative or positive - see explanation below)
    - `voters`: An `Array` of `Principal` representing the voters who have voted on the proposal.

_In this module, we will construct a simple voting system for the DAO. Each member can cast an Up or Down vote for a proposal, with their voting power being equivalent to the number of tokens they possess. A proposal gets approved once it garners 100 Up votes. Conversely, it's declined if it accumulates -100 votes. Proposals with vote counts between -100 and 100 will continue to stay open for voting. This is a very simple voting system with many limitations, it's not meant to be used in a real DAO._

### Task 2 : Implement the `proposals` variable
Implement an immutable variable called `proposals` of type `TrieMap<Nat, Proposal>`. In this datastructure, the keys are of type `Nat` and represent the unique identifier of each proposal. The values are of type `Proposal` and represent the proposal itself. You will also implement a variable `nextProposalId` that will be used to generate the unique identifier of each proposal.

### Task 3: Allow members to create proposals
The idea in this section is to allow members to create proposals to change the DAO's manifesto. 

_To avoid external malicious users from creating proposals and causing confusion, you will only allow proposals to be created by members of the DAO, who own at least 1 tokens. Each proposal creation will cost 1 token and will be burned_

#### Task 3.1: Define the `createProposalOk` type
Before we implement the `createProposal` function, we need to define the `createProposalOk` type. The `createProposalOk` type is a `Variant` type with the following cases:
- `ProposalCreated`: Represents the case when a proposal has been created of type `Nat`.

#### Task 3.2: Define the `createProposalErr` type
Before we implement the `createProposal` function, we need to define the `createProposalErr` type. The `createProposalErr` type is a `Variant` type with the following cases:
- `NotDAOMember`: Represents the case when a member is not a member of the DAO.
- `NotEnoughTokens`: Represents the case when a member doesn't have enough tokens to create a proposal.

#### Task 3.3: Define the `createProposalResult` type
To improve clarity and readability, we will define a `createProposalResult` type that is a `Result` type with the following `err` and `ok` types:
- `err`: The `createProposalErr` type.
- `ok`: The `createProposalOk` type.

#### Task 3.4: Implement the `createProposal` function
The `createProposal` function should:
- Accept a `Text` as an argument
- If the conditions mentionned earlier are verified, create a new proposal with the following fields:
    - `id`: The unique identifier of the proposal. You can use the `nextProposalId` variable to generate this value.
    - `status`: The status of the proposal. It should be set to `Open`.
    - `manifest`: The new manifesto. It should be set to the value of the argument.
    - `votes`: The value of the votes received by the proposal. It should be set to `0`.
    - `voters`: The list of voters who have voted on the proposal. It should be set to an empty `Array`.
- If the conditions are not met, the function will return the error corresponding to the reason why the proposal couldn't be created.
- Add the proposal to the `proposals` variable.
- Increment the `nextProposalId` variable by `1`.
- Return the `ProposalCreated` case of the `createProposalOk` type with the value of the proposal's `id` field.

```motoko
createProposal : shared (manifest : Text) -> async createProposalResult;
```

### Task 4: Implement the `getProposal` query function
The `getProposal` function should:
- Accept a `Nat` as an argument.
- Return the proposal with the corresponding identifier as a `?Proposal`. If no proposal exists with the given identifier, it should return `null`.
```motoko
getProposal : shared (id : Nat) -> async ?Proposal;
```

### Task 5: Allow members to vote on proposals
The idea in this section is to allow members to vote on proposals. In this section to keep things simple, the voting power of each member is equivalent to the number of tokens they possess.

_To avoid external malicious users from voting on proposals and causing confusion, you will only allow members to vote on proposals that exist and that are still open for voting. Each vote will cost 1 token and will be burned._

### Task 5.1: Define the `voteErr` type
Before we implement the `vote` function, we need to define the `voteErr` type. The `voteErr` type is a `Variant` type with the following cases:
- `ProposalNotFound`: Represents the error when a proposal with the given identifier doesn't exist.
- `AlreadyVoted`: Represents the error when a member has already voted on a proposal.
- `ProposalEnded`: Represents the error when a member tries to vote on a proposal that has already been accepted or refused.

### Task 5.2: Define the `voteOk` type
Before we implement the `vote` function, we need to define the `voteOk` type. The `voteOk` type is a `Variant` type with the following cases:
- `ProposalAccepted`: Represents the case when a proposal has been accepted.
- `ProposalRefused`: Represents the case when a proposal has been refused.
- `ProposalOpen`: Represents the case when a proposal is still open for voting.

### Task7 5.3: Define the `voteResult` type
To improve clarity and readability, we will define a `voteResult` type that is a `Result` type with the following `err` and `ok` types:
- `err`: The `voteErr` type.
- `ok`: The `voteOk` type.

### Task 5.4: Implement the `vote` function
The `vote` function should:
- Accept a `Nat` and a `Bool` as arguments.
- Get the proposal with the corresponding identifier using the `getProposal` function.
- If the proposal doesn't exist, return the `ProposalNotFound` error.
- If the proposal exists, check if the member has already voted on the proposal. If they have, return the `AlreadyVoted` error.
- If the member hasn't voted on the proposal, check if the proposal is still open for voting. If it isn't, return the `ProposalEnded` error.
- If the proposal is still open for voting, update the proposal's `votes` field by adding the member's voting power to it. If the proposal's `votes` field is greater than or equal to `100`, set the proposal's `status` field to `Accepted` and return the `ProposalAccepted` case. If the proposal's `votes` field is less than or equal to `-100`, set the proposal's `status` field to `Refused` and return the `ProposalRefused` case. If the proposal's `votes` field is between `-100` and `100`, return the `ProposalOpen` case.

```motoko
vote : shared (id : Nat, vote : Bool) -> async VoteResult;
```

## 📺 Interface
Your canister should implement the following interface:
```motoko
actor {
    createProposal : shared (manifest : Text) -> async createProposalResult;
    getProposal : shared (id : Nat) -> async ?Proposal;
    vote : shared (id : Nat, vote : Bool) -> async voteResult;
}
```

## 📚 Resources
| Name | Type | URL | Description |
| ---- | ---- | --- | ----------- |
| Upgrading a canister | Lesson | [Chapter 12](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-13/CHAPTER-13.MD) | Learn how canisters can be upgraded and the challenges that come with it. 
| Variant | Documentation | [The Variant type](https://web3.motoko-book.dev/common-programming-concepts/types/variants.html) | Everything to know about the Variant type.
| The Network Nervous System (NNS) | Appendix | [Appendix 2](https://github.com/motoko-bootcamp/dao-adventure/blob/main/appendix/appendix-1/APPENDIX-1.MD) | Discover how the most advanced DAO on the Internet Computer takes decision.
