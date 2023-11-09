# Level 3 - Supercharging your DAO with economic power
## Introduction

Walking through the Motoko Academy, you hear students talking about a new room. They say it's about making your DAO come alive. You decide to see for yourself and soon find a giant room. 

Inside, screens come alive with graphs and data, illustrating the flow of tokens within various DAOs and markets. These tokens are more than just digital coins. It's about recognizing and rewarding contributions, big and small, and ensuring the sustainability of the dream everyone is building together. 

With every step you take, you understand more. DAOs are not just about dreams or community; they are about fueling those dreams, supporting that community and giving it a structure. And the token? It's the fuel power.

The AI voice, now familiar, resonates: "**How will you empower your dream?**"

You are here to find out. It's time to understand the importance of economic strategy and to charge your DAO, making it robust, sustainable, and powerful.
## 🎯 Mission
Your mission, should you choose to accept it, is to implement a token that will be used for your DAO. <br/>

To help you get started, in [main.mo](../../src/main.mo) we've we've introduced the concept of accounts and subaccounts. Here's what you need to know:

1. **Principal and Subaccount**: A principal can possess multiple accounts. Each of these accounts is uniquely identified by a 32-byte string termed as a 'subaccount'. Thus, an individual account is represented by a combination of a principal and its corresponding subaccount.
2. **Default Subaccount**: If every byte in a subaccount string is set to '0', it designates that account as the default account for the principal.
3. **Motoko Type Definitions**:
- `Subaccount`: Represents the 32-byte identifying string for an account.
```motoko
type Subaccount = Blob;
``````
- `Account`: Denotes an account, comprised of its owner of type `Principal` and an optional subaccount of type `?Subaccount`.
```motoko
type Account = {
    owner : Principal;
    subaccount : ?Subaccount;
};
```
### Task 1 : Define the `ledger` variable
Implement an immutable variable called ledger of type `TrieMap<Account, Nat>`. In this datastructure, the keys are of type `Account` and the values are of type `Nat` and represent the balance of each account. 

_Leverage the helper functions in `account.mo` to help you._

### Task 2 : Implement the `name` query function
The `name` function should:
- Return the name of your token as a `Text`.
_You can choose any name you want for your token._

```motoko
name : shared query () -> async Text;
```
### Task 3 : Implement the `symbol` query function
The `symbol` function should:
- Return the symbol of your token as a `Text`.
_For your token, choose a symbol that is exactly 3 characters in length._

```motoko
symbol : shared query () -> async Text;
```
### Task 4: Implement the `mint` function
The `mint` function should:
- Accept a `Principal` and a `Nat` as arguments.
- Add the `Nat` to the balance of the default account of the given `Principal` in the `ledger` variable.
- Returns `()`

```motoko
mint : shared (Principal, Nat) -> async ();
```

_In a real world scenario, the `mint` function would be restricted to a specific set of identities or principals. For the purpose of this exercise, we will not be implementing this restriction._

### Task 5: Implement the `transfer` function
The transfer function should:

- Accept an `Account` object for the sender (`from`), an `Account` object for the recipient (`to`), and a `Nat` value for the amount to be transferred.
- Transfer the specified amount of tokens from the sender's account to the recipient's account.
- Return an error message wrapped in an `Err` result if the caller does not have enough tokens in its main account.
- Return `()` wrapped in a `Ok` result if the transfer is successful.
    
```motoko
transfer : shared (from : Account, to : Account, amount:  Nat) -> async Result<(), Text>;
```
### Task 6: Implement the `balanceOf` query function
The `balanceOf` function should:
- Accept an `Account` object as an argument.
- Return the balance of the given account as a `Nat`.
- Returns 0 if the account does not exist in the `ledger` variable.

```motoko
balanceOf : shared (account : Account) -> async Nat;
```
### Task 7: Implement the `totalSupply` query function
The `totalSupply` function should:
- Return the total supply of your token as a `Nat`.

```motoko
totalSupply : shared query () -> async Nat;
```
## 📺 Interface
Your canister should implement the following interface:

```motoko
actor {
    name : shared query () -> async Text;
    symbol : shared query () -> async Text;
    mint : shared (Principal, Nat) -> async ();
    transfer : shared (from : Account, to : Account, amount:  Nat) -> async Result<(), Text>;
    balanceOf : shared (account : Account) -> async Nat;
    totalSupply : shared query () -> async Nat;
}
```

## 📚 Resources
| Name | Type | URL | Description |
| ---- | ---- | --- | ----------- |
| Handle errors | Lesson | [Chapter 9](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-9/CHAPTER-9.MD) | Discover how to handle errors in Motoko |
| Identity | Lesson | [Chapter 10](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-10/CHAPTER-10.MD) | Learn how identity works on the Internet Comptuer |
| Intercanister | Lesson | [Chapter 11](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-11/CHAPTER-11.MD) | Learn how to perform intercanister calls in Motoko |
| Candid | Lesson | [Chapter 11](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-11/CHAPTER-11.MD) | Learn how to perform inter-canister calls on the Internet Computer|
| Result  | Documentation | [Base Library - Result](https://internetcomputer.org/docs/current/motoko/main/base/Result) | The official documentation for the `Result` library in Motoko |