# Project 1 - What is your dream?

<img src="../../../assets/day_1/project/cover.png"  style="width: 100%;" />

## 💭 Story

"**Welcome to the Motoko Academy - we are thrilled to have you here!**" As you stand at the entrance, a large luminous hologram greets you.

Behind the glow of the hologram, the large hall opens up, filled with energy and innovation. You first notice the screens filled with lines of code - it's not just display, you can see live feeds of ongoing projects, showcasing the real-time development of groundbreaking applications and systems.
technology. This hall isn't just a typical classroom. It’s clear that this is a place of growth, discovery, and connection to something greater than oneself.

While you're lost in your thought, the artifical voice from the hologram gently asks: "**What is your dream?**"
Today is time to grow and develop your vision.

## 🎯 Mission

Your task, should you decide to embark on this journey, is to lay down the foundation and set the direction for the DAO you are about to build. We believe that a strong foundation is key to creating a successful DAO, and it all starts with a clear and well-defined dream. <br/>
So, take this moment to reflect:

1. What changes do you aspire to see in the world?
2. What is your personal vision for the future?
3. If you had access to unlimited resources, what would you be passionate about doing?
4. If you had the backing of a community, what kind of project or initiative would you like to undertake?

## 👨‍🏫 Requirements

- Your project has a name and a clear mission statement (i.e the manifesto).
- Your DAO has a set of goals that will help you achieve your mission.
- Anyone is able to query the name, manifesto and goals of your DAO.

## ✏️ Tasks

1. Define an immutable variable `name` of type `Text` that represents the name of your DAO.
2. Define a mutable variable `manifesto` of type `Text` that represents the manifesto of your DAO.

> A manifesto is a public declaration of the intentions, motives, or views of an individual or group. It is often political in nature, but may present an individual's life stance.

3. Implement the `getName` query function, this function takes no parameters and returns the name of your DAO.

```motoko
getName : shared query () -> async Text;
```

4. Implement the `getManifesto` query function, this function takes no parameters and returns the manifesto of your DAO.

```motoko
getManifesto : shared query () -> async Text;
```

5. Implement the `setManifesto` function, this function takes a `newManifesto` of type `Text` as a parameter, updates the value of `manifesto` and returns nothing.

```motoko
setManifesto : shared (manifesto : Text) -> async ();
```

6. Define a mutable variable `goals` of type `Buffer<Text>` will store the goals of your DAO.
7. Implement the `addGoal` function, this function takes a `goal` of type `Text` as a parameter, adds a new `goal` to the `goals` buffer and returns nothing.

```motoko
addGoal : shared (goal : Text) -> async ();
```

8. Implement the `getGoals` query function, this function takes no parameters and returns all the `goals` of your DAO in an `Array`.

```motoko
getGoals : shared query () -> async [Text];
```

## 📺 Interface

At the end of this level, your canister should implement the following interface:

```motoko
actor {
    getName : shared query () -> async Text;
    getManifesto : shared query () -> async Text;
    setManifesto : shared (manifesto : Text) -> async ();
    addGoal : shared (goal : Text) -> async ();
    getGoals : shared query () -> async [Text];
}
```
