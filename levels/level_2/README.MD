# Level 2 - Building bonds
## Introduction
After a few days at the Motoko Academy, you realize that the power of the institution is not in the code or books but in it's people. Everywhere you look you see students having intense and passionate conversation. Some are even brainstorming and coding together. The atmosphere is electric and you can feel the energy in the air.

You quickly understand that to thrive in this environment, you need to build bonds with your fellow students. You need to find your tribe.

## 🎯 Mission
Your mission, should you choose to accept it, is to make it possible for your fellow students to join as members of your DAO. You might not know it yet, but you need them. Some of them might also share your vision and want to join you on your journey.

To help you get started, we define differnet types:
- A new type `Member` that will represent a student who is a member of your DAO. 
```motoko
type Member = {
    name: Text;
    age : Nat;
};
```
- A type `Result` that we've imported from the `Result` library. This type will be used to return potential errors from your functions.
``` motoko
type Result<A,B> = Result.Result<A,B>;
```
- A type `HashMap` that we've imported from the `HashMap` library. This type will be used to store the members of your DAO.
```motoko
type HashMap<K,V> = HashMap.HashMap<K,V>;
```

### Task 1: Define the `members` variable
Implement a mutable variable `members` of type `Hashmap<Principal,Member>` that will store the members of your DAO.

### Task 2: Implement the `addMember` function
The `addMember` function should: 
- Take a `member` as a parameter of type `Member`
- Check if the `caller` is already a member of your DAO. 
    - If so, return an error message of type `Text` wrapped in `Err` indicating that the `caller` is already a member.
    - If not, add the `member` to the `members` hashmap with the `caller` as the key and return nothings wrapped in `Ok`.
```motoko
addMember : shared (member : Member) -> async Result<(),Text>;
```
### Task 3: Implement the `getMember` query function
The `getMember` function should:
- Take a principal of type `Principal` as a parameter
- Return the `Member` corresponding to the `principal` wrapped in `Ok` if it exists, otherwise return an error message of type `Text`  wrapped in `Err`.
```motoko 
getMember : shared query (principal : Principal) -> async Result<Member,Text>;
```
### Task 4: Implement the `updateMember` function
The `updateMember` function should:
- Take a `member` of type `Member` as a parameter
- Check if the `caller` is a member of your DAO. 
    - If not, return an error message of type `Text` wrapped in `Err` indicating that the `caller` is not a member.
    - If so, update the `member` in the `members` hashmap with the `caller` as the key and return nothings wrapped in `Ok`.
```motoko
updateMember : shared (member : Member) -> async Result<(),Text>;
```

### Task 5: Implement the `getAllMembers` query function
The `getAllMembers` function should:
- Return all the members of your DAO as an array of type `[Member]`.
```motoko
getAllMembers : shared query () -> async [Member];
```
### Task 6: Implement the `numberOfMembers` query function
The `numberOfMembers` function should:
- Return the number of members of your DAO as a `Nat`.
```motoko
numberOfMembers : shared query () -> async Nat;
```
### Task 7: Implement the `removeMember` function
The `removeMember` function should:
- Take a `principal` of type `Principal` as a parameter
- Check if the `caller` is a member of your DAO. 
    - If not, return an error message of type `Text` wrapped in `Err` indicating that the `caller` is not a member.
    - If so, remove the `member` from the `members` hashmap with the `caller` as the key and return nothings wrapped in `Ok`.
```motoko
removeMember : shared (principal : Principal) -> async Result<(),Text>;
```
## 📺 Interface
Your canister should implement the following interface:

```motoko
actor {
    addMember : shared (member : Member) -> async Result<(),Text>;
    updateMember : shared (member : Member) -> async Result<(),Text>;
    removeMember : shared (principal : Principal) -> async Result<(),Text>;
    getMember : shared query (principal : Principal) -> async Result<Member,Text>;
    getAllMembers : shared query () -> async [Member];
    numberOfMembers : shared query () -> async Nat;
}
```
## 📚 Resources
| Name | Type | URL | Description |
| ---- | ---- | --- | ----------- |
| Datastructures | Lesson | [Chapter 6](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-6/CHAPTER-6.MD) | Learn about common datastructures in Motoko and how to use them - a must read! |
| Non-Primitives Types  | Lesson | [Chapter 7](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-7/CHAPTER-7.MD) | Learn about non-primitive types in Motoko such as Tuples, Objects and Variants  | 
| Advanced Types  | Lesson | [Chapter 8](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-8/CHAPTER-8.MD) | Discover more advanced types such as Optional, Generic or Shared types |
| Result  | Documentation | [Base Library - Result](https://internetcomputer.org/docs/current/motoko/main/base/Result) | The official documentation for the `Result` library in Motoko |
| HashMap  | Documentation | [Base Library - HashMap](https://internetcomputer.org/docs/current/motoko/main/base/HashMap) | The official documentation for the `HashMap` library in Motoko |
