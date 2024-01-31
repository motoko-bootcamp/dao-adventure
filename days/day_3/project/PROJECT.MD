# Project 3 - Supercharging your DAO with economic power

<img src="../../../assets/day_3/project/cover.png"  style="width: 100%;"/>

## 💭 Story

Walking through the Academy, you hear noises coming from behind a door. You decide to see for yourself and soon enter inside a giant room. Inside the room, screens come alive with graphs and data, illustrating the flow of tokens. It's like the **NYSE** but for DAOs.

That's when it hit you. Tokens are the lifeblood of DAOs. The tokens are more than just digital coins. It's about recognizing and rewarding contributions, big or small, and ensuring the sustainability of the dream everyone is building together. With every new day at the academy, you understand a bit more the essence of DAOs. DAOs are not just about dreams or community, they are also about giving those dreams a structure and supporting a community.

Today, it's time to supercharge your DAO with a token.

## 🎯 Mission

Today, your mission, is to implement the code for a token. <br/>
On the Internet Computer, we can create a token by creating a canister that stores balances and manage transfer. Assuming the canister is not controlled we can consider the token to be safe, trustless and decentralized. In this project you will implement the code for a simple token. If you are interested in learning more about tokens, you can read the [ICRC_1](https://internetcomputer.org/docs/current/developer-docs/integrations/icrc-1/) standard.

## 👨‍🏫 Requirements

> In a real world scenario, the `mint` function would be restricted to a specific set of identities. For the sake of simplicity, we will not implement this restriction. The same applies to the `burn` method.

- The token has a name and a symbol.
- The token has a total supply.
- Anyone can mint tokens.
- Anyone can burn tokens.
- Anyone can transfer tokens to another person assuming they have enough tokens.

## ✏️ Tasks

1. Define the `ledger` variable. This variable will be used to store the balance of each user. The key of the `ledger` variable is of type `Principal` and the value is of type `Nat`. You can use the `HashMap` or `TrieMap` types to implement this variable.

2. Implement the `tokenName` function, this function takes no parameters and returns the name of your token as a `Text`.

```motoko
tokenName : shared query () -> async Text;
```

> Choose any name you want for your token.

3. Implement the `tokenSymbol` function, this function takes no parameters and returns the symbol of your token as a `Text`.

```motoko
tokenSymbol : shared query () -> async Text;
```

> For your token, choose a symbol that is exactly 3 characters in length.

4. Implement the `mint` function. This function takes a `Principal` and a `Nat` as arguments. It adds the `Nat` to the balance of the given `Principal`. You will use the `Result` type for your return value.

```motoko
mint : shared (p : Principal, amount : Nat) -> async ();
```

5. Implement the `burn` function. This function takes a `Principal` and a `Nat` as arguments. It subtracts the `Nat` from the balance of the given `Principal`. You will use the `Result` type for your return value.

```motoko
burn : shared (p : Principal, amount : Nat) -> async Result<(), Text>;
```

5. Implement the `transfer` function. This function takes a `Principal` representing the sender (`from`), a `Principal` representing the recipient (`to`), and a `Nat` value for the amount to be transferred. It transfers the specified amount of tokens from the sender's account to the recipient's account. You will use the `Result` type for your return value.

```motoko
transfer : shared (from : Principal, to : Principal, amount:  Nat) -> async Result<(), Text>;
```

6. Implement the `balanceOf` query function. This function takes a `Princopal` as an argument and returns the balance of the given account as a `Nat`. It should return 0 if the account does not exist in the `ledger` variable.

```motoko
balanceOf : shared (p : Principal) -> async Nat;
```

7. Implement the `totalSupply` query function. This function takes no parameters and returns the total supply of your token as a `Nat`.

```motoko
totalSupply : shared query () -> async Nat;
```

## 📺 Interface

At the end of this level, your canister should implement the following interface:

```motoko
actor {
    tokenName : shared query () -> async Text;
    tokenSymbol : shared query () -> async Text;
    mint : shared (owner : Principal, amount : Nat) -> async Result<(), Text>;
    burn : shared (owner : Principal, amount : Nat) -> async Result<(), Text>;
    transfer : shared (from : Principal, to : Principal, amount:  Nat) -> async Result<(), Text>;
    balanceOf : shared (p : Principal) -> async Nat;
    totalSupply : shared query () -> async Nat;
}
```
