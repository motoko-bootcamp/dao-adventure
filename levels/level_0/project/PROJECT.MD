# Level 0 - The Initiation Challenge

<p> <img src="../../../assets/level_0/project/academy.webp" alt="Build" /> </p>

## Introduction

_In an alternate universe, the digital world is divided into various lands, with the Motoko Academy towering above the clouds. This prestigious academy is not just about learning to code; it's a place where novices are transformed into digital architects who shape the future of the digital world._

_The academy has a crucial initiation ritual, **The 1st dApp Challenge.** Aspirants must conquer this challenge to gain entry into the academy and unlock the mysteries of DAOs._

_At the heart of Motoko Academy lies the **Digital Legacy Scroll**, a dynamic record of achievement. Whenever a student successfully develops their app, their name and a personal message about their aspirations are added to this scroll. It serves as a living testament to the hard work and success of the academy's students, inspiring and celebrating their achievements._

_But the rewards extend beyond the scroll. Those who make it onto the list are granted access to **OpenChat**, an exclusive digital space reserved for the elite. This sanctuary for the curious and ambitious is rumored to hold the secrets to creating a DAO, making it a coveted destination for aspiring digital architects._

_As you approach the grand entrance, a luminous hologram greets you with an inviting voice, "Ready to shape the digital future?" It stands as the guardian of knowledge at the academy, guiding aspirants on their journey._

<p> <img src="../../../assets/level_0/project/challenge.webp" alt="Build" /> </p>

## 🎯 Mission

Your task, should you decide to embark on this journey, is to deploy your first application on the Internet Computer. <br/>

To do so we will use the Motoko Playground, which is an online coding environment, so you won't need to install anything on your computer!

## ✏️ Tasks

0. Register on the [Motoko Bootcamp Dashboard](motokobootcamp.com) and create an account.
1. Develop your application by completing the 5 tasks in [main.mo](src/main.mo).
2. Deploy your application and submit it on [motokobootcamp.com](motokobootcamp.com).
3. Leave your mark on the [Digital Legacy Scroll](https://aki3l-syaaa-aaaaj-qa23q-cai.ic0.io/).
4. Unlock the private Motoko Bootcamp OpenChat Group and join a community of innovators and thinkers.

## 📺 Interface

At the end of this level, your canister should implement the following interface:

```motoko
actor {
    getName : shared query () -> async Text;
    getMessage : shared query () -> async Text;
    setMessage : shared (message : Text) -> async ();
}
```
