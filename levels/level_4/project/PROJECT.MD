# Level 4 - The collective voice

<img src="../../../assets/level_4/project/cover.png"  style="width: 100%;"/>

## Introduction

Walking through the Academy, you hear a mix of different sounds, like a music. Following the sound, you come to a big area.

Inside, students are grouped together, each singing a different note or using a different instrument, yet harmoniously contributing to an enchanting melody. The guiding AI floats by, whispering, "_Just as in music, a DAO should translate individual voices into harmonious decisions._"

You're about to learn that in a DAO, making choices isn't about the loudest voice, but about ensuring every voice contributes to the collective song. It's time to orchestrate your DAO's voting system, letting every member strike their note.

## 🎯 Mission

Your mission, should you choose to accept it, is to implement a voting system for your DAO.

> Today, our focus is on setting up a voting system for the DAO with different types of proposals. Specifically, in this level, we will create a voting mechanism for changing the DAO's manifesto defined in Level 1. This level relies on variables and functions implemented in previous levels, so it's advisable to complete those first if you haven't already.

> In this voting system, each member can vote 'Up' or 'Down' on a proposal. They can vote multiple times on a single proposal, but each vote costs one token. A proposal is accepted when it receives 10 'Up' votes and rejected when it accumulates -10 'Down' votes. Keep in mind that this voting system is quite basic and not suitable for real DAO us

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
createProposal : shared (manifest : Text) -> async CreateProposalResult;
```

4. Implement the `getProposal` query function. This function takes a `Nat` as an argument and returns the proposal with the corresponding identifier as a `?Proposal`. If no proposal exists with the given identifier, it should return `null`.

```motoko
getProposal : shared (id : Nat) -> async ?Proposal;
```

To help you moving forward we've defined the following types:

- `VoteOk` : Represents the case when a vote is accepted. The `VoteOk` type is a `Variant` type with the following cases:

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

- `VoteErr` : Represents the possible errors when submitting a vote. The `VoteErr` type is a `Variant` type with the following cases:

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

5. Implement the `vote` function that takes a `Nat` and a `Bool` as arguments and returns a `VoteResult` type. This function will be used to vote on a proposal. The `Nat` represents the identifier of the proposal and the `Bool` represents the vote. If the `Bool` is `true`, the vote is an `Up` vote. If the `Bool` is `false`, the vote is a `Down` vote. The function should perfom necessary checks before accepting a vote.

> To avoid external malicious users from voting on proposals and causing confusion, you will only allow members to vote on proposals that exist and that are still open for voting. Each vote will cost 1 token and will be burned. Make sure to perform the necessary checks before accepting a vote.

```motoko
vote : shared (id : Nat, vote : Bool) -> async VoteResult;
```

## 📺 Interface

At the end of this level, your canister should implement the following interface:

```motoko
actor {
    createProposal : shared (manifest : Text) -> async CreateProposalResult;
    getProposal : shared (id : Nat) -> async ?Proposal;
    vote : shared (id : Nat, vote : Bool) -> async VoteResult;
}
```
