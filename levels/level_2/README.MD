# Level 2 - Building bonds
<img src="../../assets/level_2/cover.png"  style="width: 100%;"/>

## Introduction

After a few days at the Academy, you realize that the power of the institution is not in the code or books but in it's people. Everywhere you look you see students having intense and passionate conversation. Some are even brainstorming and coding together. The atmosphere is electric and you can feel the energy in the air.

You quickly understand that to thrive in this environment, you need to build bonds with your fellow students. You need to find your tribe.

## 🎯 Mission

Your mission, is to make it possible for your fellow students to join as members of your DAO. You might not know it yet, but you need them, if you want the DAO to evolve.

To help you get started, we've defined different types in [main.mo](../../src/main.mo):

- A new type `Member` to represent the members of your DAO.

```motoko
type Member = {
    name: Text;
    age : Nat;
};
```

- A new type `Result` that we've imported from the `Result` library. This type will be used to return potential errors from your functions.

```motoko
type Result<A,B> = Result.Result<A,B>;
```

- A type `HashMap` that we've imported from the `HashMap` library. This type will be used to store the members of your DAO.

```motoko
type HashMap<K,V> = HashMap.HashMap<K,V>;
```

## ✏️ Tasks

1. Define an immutable variable `members` of type `Hashmap<Principal,Member>` that will be used to store the members of your DAO.

> You might be wondering why we're using an immutable variable in this context, especially when we plan to add members to the data structure. The reason for this choice is that we are using a HashMap, and our intention is not to change the reference to the HashMap itself, but rather to modify the content within the HashMap.

2. Implement the `addMember` function, this function takes a `member` of type `Member` as a parameter, adds a new `member` to the `members` hashmap. The function should check if the `caller` is already a member. If that's the case use the `Result` type to return an error message.

```motoko
addMember : shared (member : Member) -> async Result<(),Text>;
```

3. Implement the `getMember` query function, this function takes a `principal` of type `Principal` as a parameter and returns the corresponding member. You will us the `Result` type for your return value.

```motoko
getMember : shared query (principal : Principal) -> async Result<Member,Text>;
```

4. Implement the `updateMember` function, this function takes a `member` of type `Member` as a parameter and updates the corresponding member. You will us the `Result` type for your return value. If the member doesn't exist, return an error message.

```motoko
updateMember : shared (member : Member) -> async Result<(),Text>;
```

5. Implement the `getAllMembers` query function, this function takes no parameters and returns all the members of your DAO as an array of type `[Member]`.

```motoko
getAllMembers : shared query () -> async [Member];
```

6. Implement the `numberOfMembers` query function, this function takes no parameters and returns the number of members of your DAO as a `Nat`.

```motoko
numberOfMembers : shared query () -> async Nat;
```

7. Implement the `removeMember` function, this function takes a `principal` of type `Principal` as a parameter and removes the corresponding member. You will us the `Result` type for your return value. If the member doesn't exist, return an error message.

```motoko
removeMember : shared () -> async Result<(),Text>;
```

## 📺 Interface

At the end of this level, your canister should implement the following interface:

```motoko
actor {
    addMember : shared (member : Member) -> async Result<(),Text>;
    updateMember : shared (member : Member) -> async Result<(),Text>;
    removeMember : shared () -> async Result<(),Text>;
    getMember : shared query (principal : Principal) -> async Result<Member,Text>;
    getAllMembers : shared query () -> async [Member];
    numberOfMembers : shared query () -> async Nat;
}
```

## 📚 Resources

This set of resources will help you complete this level and contains useful information for your journey ahead.

| Name                 | Type          | URL                                                                                                    | Description                                                                    |
| -------------------- | ------------- | ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ |
| Datastructures       | Lesson        | [Chapter 6](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-6/CHAPTER-6.MD) | Learn about common datastructures in Motoko and how to use them - a must read! |
| Non-Primitives Types | Lesson        | [Chapter 7](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-7/CHAPTER-7.MD) | Learn about non-primitive types in Motoko such as Tuples, Objects and Variants |
| Advanced Types       | Lesson        | [Chapter 8](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-8/CHAPTER-8.MD) | Discover more advanced types such as Optional, Generic or Shared types         |
| Result               | Documentation | [Base Library - Result](https://internetcomputer.org/docs/current/motoko/main/base/Result)             | The official documentation for the `Result` library in Motoko                  |
| HashMap              | Documentation | [Base Library - HashMap](https://internetcomputer.org/docs/current/motoko/main/base/HashMap)           | The official documentation for the `HashMap` library in Motoko                 |
