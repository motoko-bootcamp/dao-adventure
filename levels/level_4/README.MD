# Level 4 - The collective voice
<img src="../../assets/level_4/cover.png"  style="width: 100%;"/>

## Introduction

Walking through the Academy, you hear a mix of different sounds, like a music. Following the sound, you come to a big area.

Inside, students are grouped together, each singing a different note or using a different instrument, yet harmoniously contributing to an enchanting melody. The guiding AI floats by, whispering, "_Just as in music, a DAO should translate individual voices into harmonious decisions._"

You're about to learn that in a DAO, making choices isn't about the loudest voice, but about ensuring every voice contributes to the collective song. It's time to orchestrate your DAO's voting system, letting every member strike their note.

## 🎯 Mission

Your mission, should you choose to accept it, is to implement a voting system for your DAO.

> Setting up a voting system with different types of proposals is a challenging endeavour. Today, we're only going to set up a way for everyone to vote on changing the DAO's manifesto that we have defined in Level 1. That's our only focus for this level.

> This level will make use of variables and functions that you have implemented in previous levels. If you haven't completed the previous levels, we recommend you do so before starting this one.

> In this level, we will build a simple voting system for the DAO. Each member can cast Up or Down for each proposal. They can vote as much time as they want on a specific proposal, but each time they vost it costs them one token. This is a very simple voting system with many limitations, it's not meant to be used in a real DAO.

## ✏️ Tasks

To help you get started we've defined different types in [main.mo](../../src/main.mo):

- A new type `Status` to represent the status of a proposal. It can be either `Open`, `Accepted` or `Refused`.

```motoko
public type Status = {
    #Open;
    #Accepted;
    #Rejected;
};
```

- A new type `Proposal` to represent a proposal. It has the following fields:
  - `id`: A `Nat` representing the unique identifier of the proposal.
  - `status`: A `Status` representing the status of the proposal.
  - `manifest`: A `Text` representing the new manifesto.
  - `votes`: A `Int` representing the value of the votes received by the proposal. (This value can be negative or positive - see explanation below)
  - `voters`: An `Array` of `Principal` representing the voters who have voted on the proposal.

```motoko
public type Proposal = {
    id : Nat;
    status : Status;
    manifest : Text;
    votes : Int;
    voters : [Principal];
};
```

1. Define a mutable variable `nextProposalId` of type `Nat` that will keep track of the next proposal's identifier. Every time a proposal is created, this variable will be incremented by `1`.
2. Define an immutable variable called `proposals` of type `TrieMap<Nat, Proposal>`. In this datastructure, the keys are of type `Nat` and represent the unique identifier of each proposal. The values are of type `Proposal` and represent the proposal itself.

To help you moving forward we've defined the following types:

- `CreateProposalOk` : Represents the case when a proposal has been created. It's an alias to the type `Nat`.

```motoko
public type CreateProposalOk = Nat;
```

- `CreateProposalErr` : Represents the possible errors when submitting a proosal. It's a `Variant` type with the following cases:
  - `NotDAOMember`: Represents the case when a member is not a member of the DAO.
  - `NotEnoughTokens`: Represents the case when a member doesn't have enough tokens to create a proposal.

```motoko
public type CreateProposalErr = {
    #NotDAOMember;
    #NotEnoughTokens;
};
```

- `CreateProposalResult` : Represents the result of the `createProposal` function. It's a `Result` type with the following `err` and `ok` types:
  - `err`: The `CreateProposalErr` type.
  - `ok`: The `CreateProposalOk` type.

```motoko
public type CreateProposalResult = Result<CreateProposalOk, CreateProposalErr>;
```

3. Implement the `createProposal` function. This function takes a `manifest` of type `Text` as a parameter and returns a `CreateProposalResult` type. This function will be used to create a new proposal. The function should check if the caller is a member of the DAO and if they have enough tokens to create a proposal. If that's the case, the function should create a new proposal and return the `ProposalCreated` case of the `CreateProposalOk` type with the value of the proposal's `id` field. Otherwise it should return the corresponding error.

> To avoid external malicious users from creating proposals and causing confusion, you will only allow proposals to be created by members of the DAO, who own at least 1 tokens. Each proposal creation will cost 1 token and will be burned.

```motoko
createProposal : shared (manifest : Text) -> async createProposalResult;
```

4. Implement the `getProposal` query function. This function takes a `Nat` as an argument and returns the proposal with the corresponding identifier as a `?Proposal`. If no proposal exists with the given identifier, it should return `null`.

```motoko
getProposal : shared (id : Nat) -> async ?Proposal;
```

To help you moving forward we've defined the following types:

- `VoteOk` : Represents the case when a vote is accepted. The `voteOk` type is a `Variant` type with the following cases:

  - `ProposalAccepted`: Represents the case when a proposal has been accepted after a vote.
  - `ProposalRefused`: Represents the case when a proposal has been refused after a vote.
  - `ProposalOpen`: Represents the case when a proposal is still open for voting after a vote.

  ```motoko
  public type VoteOk = {
      #ProposalAccepted;
      #ProposalRefused;
      #ProposalOpen;
  };
  ```

- `VoteErr` : Represents the possible errors when submitting a vote. The `voteErr` type is a `Variant` type with the following cases:

  - `ProposalNotFound`: Represents the error when a proposal with the given identifier doesn't exist.
  - `AlreadyVoted`: Represents the error when a member has already voted on a proposal.
  - `ProposalEnded`: Represents the error when a member tries to vote on a proposal that has already been accepted or refused.
  - `NotEnoughTokens`: Represents the error when a member does not have enough tokens to cast a vote.
  - `NotDAOMember`: Represents the error when the person trying to vote is not a member of the DAO.


  ```motoko
  public type VoteErr = {
      #ProposalNotFound;
      #AlreadyVoted;
      #ProposalEnded;
      #NotEnoughTokens;
      #NotDAOMember;
  };
  ```

- `VoteResult` : Represents the result of the `vote` function. It's a `Result` type with the following `err` and `ok` types:

  - `err`: The `VoteErr` type.
  - `ok`: The `VoteOk` type.

  ```motoko
  public type VoteResult = Result<VoteOk, VoteErr>;
  ```

### Task 5: Allow members to vote on proposals

The idea in this section is to allow members to vote on proposals. In this section to keep things simple, the voting power of each member is

5. Implement the `vote` function that takes a `Nat` and a `Bool` as arguments and returns a `VoteResult` type. This function will be used to vote on a proposal. The `Nat` represents the identifier of the proposal and the `Bool` represents the vote. If the `Bool` is `true`, the vote is an `Up` vote. If the `Bool` is `false`, the vote is a `Down` vote. The function should perfom necessary checks before accepting a vote.

> To avoid external malicious users from voting on proposals and causing confusion, you will only allow members to vote on proposals that exist and that are still open for voting. Each vote will cost 1 token and will be burned.

```motoko
vote : shared (id : Nat, vote : Bool) -> async VoteResult;
```

## 📺 Interface

At the end of this level, your canister should implement the following interface:

```motoko
actor {
    createProposal : shared (manifest : Text) -> async createProposalResult;
    getProposal : shared (id : Nat) -> async ?Proposal;
    vote : shared (id : Nat, vote : Bool) -> async VoteResult;
}
```

## 📚 Resources

| Name                             | Type          | URL                                                                                                        | Description                                                                 |
| -------------------------------- | ------------- | ---------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| Upgrading a canister             | Lesson        | [Chapter 12](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-13/CHAPTER-13.MD)  | Learn how canisters can be upgraded and the challenges that come with it.   |
| Variant                          | Documentation |  [The Variant type](https://web3.motoko-book.dev/common-programming-concepts/types/variants.html)          | Everything to know about the Variant type.                                  |
| The Network Nervous System (NNS) | Appendix      | [Appendix 2](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lesson/appendix-1/APPENDIX-1.MD) | Discover how the most advanced DAO on the Internet Computer takes decision. |

```

```
