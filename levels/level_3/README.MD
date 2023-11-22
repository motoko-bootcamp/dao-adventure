# Level 3 - Supercharging your DAO with economic power
<img src="../../assets/level_3/cover.png"  style="width: 100%;"/>

## Introduction

Walking through the Academy, you hear noises coming behind a door. You decide to see for yourself and soon find a giant room.

Inside, screens come alive with graphs and data, illustrating the flow of tokens within various DAOs and markets. It's like the **NYSE** but for DAOs.

Soon you come to understand that tokens are the lifeblood of DAOs. These tokens are more than just digital coins. It's about recognizing and rewarding contributions, big and small, ensuring the sustainability of the dream everyone is building together and giving it a structure.

With every step you take, you understand a bit more the essence of DAOs. DAOs are not just about dreams or community, they are about fueling those dreams, supporting a community and giving it a structure.

And the token? It's the fuel.

The AI voice, now familiar, resonates: "**How will you empower your dream?**"

You are here to find out. It's time to supercharge your DAO with a token.

## 🎯 Mission

Your mission, is to implement the code for the token that will be used for your DAO. <br/>

To help you get started, in [main.mo](../../src/main.mo) we've introduced the concept of accounts and subaccounts.

1. **Principal and Subaccount**: A principal can possess multiple accounts. Each of these accounts is uniquely identified by a 32-byte string termed as a 'subaccount'. Thus, an individual account is represented by a combination of a principal and its corresponding subaccount.
2. **Default Subaccount**: If every byte in a subaccount string is set to '0', it designates that account as the default account for the principal.
3. **Motoko Type Definitions**:

- `Subaccount`: Represents the 32-byte identifying string for an account.

```motoko
type Subaccount = Blob;
```

- `Account`: Denotes an account, comprised of its owner of type `Principal` and an optional subaccount of type `?Subaccount`.

```motoko
type Account = {
    owner : Principal;
    subaccount : ?Subaccount;
};
```

## ✏️ Tasks

1. Define the `ledger` variable. This variable will be used to store the balance of each account. The key of the `ledger` variable is of type `Account` and the value is of type `Nat`.

> Import the utilities functions in `account.mo` to help you.

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

4. Implement the `mint` function. This function takes a `Principal` and a `Nat` as arguments. It adds the `Nat` to the balance of the default account of the given `Principal` and returns nothing.

```motoko
mint : shared (Principal, Nat) -> async ();
```

> The default account is the account with a `subaccount` set to `null`.

> In a real world scenario, the `mint` function would be restricted to a specific set of identities. For the sake of simplicity, we will not implement this restriction.

5. Implement the `transfer` function. This function takes an `Account` object for the sender (`from`), an `Account` object for the recipient (`to`), and a `Nat` value for the amount to be transferred. It transfers the specified amount of tokens from the sender's account to the recipient's account. You will use the  `Result` type for your return value.

```motoko
transfer : shared (from : Account, to : Account, amount:  Nat) -> async Result<(), Text>;
```

6. Implement the `balanceOf` query function. This function takes an `Account` object as an argument and returns the balance of the given account as a `Nat`. It returns 0 if the account does not exist in the `ledger` variable.

```motoko
balanceOf : shared (account : Account) -> async Nat;
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
    mint : shared (Principal, Nat) -> async ();
    transfer : shared (from : Account, to : Account, amount:  Nat) -> async Result<(), Text>;
    balanceOf : shared (account : Account) -> async Nat;
    totalSupply : shared query () -> async Nat;
}
```

## 📚 Resources

This set of resources will help you complete this level and contains useful information for your journey ahead.

| Name          | Type          | URL                                                                                                       | Description                                                        |
| ------------- | ------------- | --------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| Handle errors | Lesson        | [Chapter 9](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-9/CHAPTER-9.MD)    | Discover how to handle errors in Motoko                            |
| Identity      | Lesson        | [Chapter 10](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-10/CHAPTER-10.MD) | Learn how identity works on the Internet Comptuer                  |
| Intercanister | Lesson        | [Chapter 11](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-11/CHAPTER-11.MD) | Learn how to perform intercanister calls in Motoko                 |
| Candid        | Lesson        | [Chapter 11](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-11/CHAPTER-11.MD) | Learn how to perform inter-canister calls on the Internet Computer |
| Result        | Documentation | [Base Library - Result](https://internetcomputer.org/docs/current/motoko/main/base/Result)                | The official documentation for the `Result` library in Motoko      |
