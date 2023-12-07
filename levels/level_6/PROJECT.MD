# Level 6 : Forging your own path

## Introduction

A DAO, which stands for Decentralized Autonomous Organization, is a new type of organization (or company) that is run leveraging blockchain technology. This enables us to create more transparent, trusted and efficient organisations.

**DAOs** are the biggest innovation in the field of governance since the invention of the [LLC](https://www.investopedia.com/terms/l/llc.asp) or perhaps even democracy itself. Just like the **steam engine** made the **Industrial Revolution** possible by harnessing physical power, DAOs harness **political power** to fuel a new type of revolution in how we fundamentally organize people and resources.

## Mission

Your goal is to build an application that leverages the power of DAOs. The future is collaborative so make sure to think about how your application can leverage the power of the crowd. The rest is up to you. If you want to build a club or a DAO for your favorite sport, a company, a school, a charity, a political party, a family, a city, a country, a planet, a galaxy, a universe, or even a multiverse, you are free to do so.

## Requirements

Even if you are free to build whatever you want, we have a few requirements that you need to follow:

Your application should:

- Be written in **Motoko** and deployed on the **Internet Computer**.
- Be open source and available on **GitHub.**
- Related to DAOs.
- Implement specific functions that are described in the [Interface]() section.

Your application should not:

- Be a direct copy of an existing application (you can get inspired by existing applications, but you need to add your own touch).

## Interface (API)

> In all the following functions, the \_MBC suffix is used to indicate that the function is implemented as a requirements for the Motoko Bootcamp. That way you can still have similar functions in your project without any conflict.

Your application should implement the following functions:

1. Implement the `getName_MBC` query function, this function takes no parameters and returns the name of your DAO or project.

- Purpose: Returns the project's name.
- Parameter: None.
- Return Type: `async Text`.
- Character Limit: Up to 50 characters.

```motoko
getNameMBC : shared query () -> async Text;
```

2. Implement the `getDescription_MBC` query function, this function takes no parameters and returns the description of your DAO or project.

- Purpose: Returns the project's description.
- Parameter: None.
- Return Type: `async Text`.
- Character Limit: Up to 500 characters.

```motoko
getDescriptionMBC : shared query () -> async Text;
```

3. Implement the `getAuthor_MBC` query function, this function takes no parameters and returns the author's name.

- Purpose: Returns the author's name.
- Parameter: None.
- Return Type: `async Text`.
- Character Limit: Up to 50 characters.

```motoko
getAuthorMBC : shared query () -> async Text;
```

We introduce a new type called Socials that is used to store socials links. Any field in the social object shouldn't be longer than 500 characters.

```motoko
public type Socials = {
    Twitter : ?Text;
    GitHub : ?Text;
    Linkedin : ?Text;
    Instagram : ?Text;
    TikTok : ?Text;
    OpenChat: ?Text;
};
```

- Purpose: Stores the socials links of the author and the project.
- Fields: `Twitter`, `GitHub`, `Linkedin`, `Instagram`, `TikTok`, `OpenChat`.
- Field Character Limit: Up to 500 characters.
- Field Type: `?Text` (optional text).
- Null handling: If no account, the value should be `null`.

For instance, for Motoko Bootcamp, our `Socials` object would look something like this:

```motoko
let MotokoBootcampSocials : Socials = {
    Twitter = <https://twitter.com/motoko_bootcamp>;
    GitHub =  <https://github.com/motoko-bootcamp>;
    Instagram = <https://www.instagram.com/motokobootcamp/>;
    TikTok = <https://www.tiktok.com/@motoko_bootcamp>;
    OpenChat: <https://oc.app/community/kvmak-aaaaa-aaaar-atmsq-cai/?ref=lfwpr-yyaaa-aaaaf-abvzq-cai>;
    Linkedin = null;
};
```

4. Implement the `getSocialsAuthor_MBC` query function, this function takes no parameters and returns the socials links of the author.

- Purpose: Returns the socials links of the author.
- Parameter: None.
- Return Type: `async Socials`.

```motoko
getSocialsAuthorMBC : shared query () -> async Socials;
```

5. Implement the `getSocialsProject_MBC` query function, this function takes no parameters and returns the socials links of the project.

- Purpose: Returns the socials links of the project.
- Parameter: None.
- Return Type: `async Socials`.

```motoko
getSocialsProjectMBC : shared query () -> async Socials;
```

We introduce a new type called `Images` that is used to store images URLs.

```motoko
public type Images = {
    urlLogo : ?Text;
    urlBanner : ?Text;
};
```

- Purpose: Returns the images URLs of the project.
- Fields: `urlLogo`, `urlBanner`.
- Logo: 400x400px / 1:1, PNG.
- Banner: 1920x1080px / 16:9, PNG.

6. Implement the `getImages_MBC` query function, this function takes no parameters and returns the images URLs of the project.

- Purpose: Returns the images URLs of the project.
- Parameter: None.
- Return Type: `async Images`.

```motoko
getImagesMBC : shared query () -> async Images;
```

## Examples

If you are looking for inspiration, here are a few examples to get you started:

1. A DAO that controls a Website

- Key Features: A DAO that controls the text displayed on an external website.
- Website: [Discuss and Vote](https://5razo-nqaaa-aaaal-abw3a-cai.icp0.io/)
- GitHub Repository: [TODO]

2. A collaborative Art Wall:

- Key Features: A platform for collective art creation and display.
- Website: [Motoko Art Wall](https://4bzoe-qiaaa-aaaal-qb4ca-cai.icp0.io/)
- GitHub Repository: [TODO]

3. A token governed through a voting system:

- Key Features: A token managed and distributed based on community voting.
- Website: [PawCoins](https://sxfbn-dyaaa-aaaap-qbgca-cai.icp0.io/)
- GitHub Repository: [TODO]

4. A DAO with a clear mission:

- Key Features: A DAO focused on building sustainable green places to live.
- Website: [Green Guild]()
- GitHub Repository: [TODO]

> The focus of the week is on a DAO, but as you've seen DAOs are central to Web3 and can be related to many different types of applications (token, governance, website, treasury, etc.). That's why you are free to build whatever you want as long as you can add a "DAO" touch to it. If you're in doubt about your idea, feel free to ask us.

## Frequently Asked Questions

### Do I need to build a frontend?

Not necessarily. We are focusing the week on Motoko. If you want to create a complex frontend you’ll need to use JavaScript and leverage existing frameworks (Angular, Vue, Svelte, React…).

If that’s something you’re already familiar with, then go ahead and show us your skills! If you are not familiar with frontend development, focus on the Motoko part and the backend.

### Do I need to integrate with the Internet Identity?

Not necessarily. A lot of the applications you’ll see integrate with it because it’s easy, efficient and works well on the Internet Computer. However, it’s the only way to authenticate users, you could also use:

1. Wallet-based solutions like [Plug](https://plugwallet.ooo/) or the [Me Wallet from AstroX](https://play.google.com/store/apps/details?id=com.astrox.me&hl=en_US&pli=1). These are different types of wallets each offering specific features.
2. [NFID,](https://nfid.one/) which builds upon Internet Identity by adding more features such as email login, credentials management, and wallet integration.

It's important to note that these authentication methods are mainly relevant for applications with a user interface (frontend). If your application doesn't have a frontend (refer to the previous question), then integrating an authentication provider is not required.

### How to get started, do you have templates?

[TODO]

### Even after brainstorming and looking at examples. I don't have any ideas, what should I build?

I got it, sometimes inspiration takes a long time to come, don't worry.
In that case, try build this sample project: [TODO]

## Graduation

To graduate you must:

- Complete the DAO adventure (Level 0 to 5) and submit all your projects on [motokobootcamp.com](https://motokobootcamp.com/).
- Build and deploy your final project on the Internet Computer, not on the local network or the playground.
- Publish your project on GitHub and share the link on the [Motoko Bootcamp Discord](https://discord.gg/2vq8T5k9).

Your Motoko Bootcamp diploma will grant you the following lifetime benefits:

- Access to a dedicated Motoko Bootcamp Graduate Channel on OpenChat.
- Access to a dedicated Motoko Bootcamp Portal on DSCVR.
- Access to the Motoko Bootcamp Manifesto.

> The Motoko Bootcamp Diploma and the associated on-chain infrastructure are still under development. We will keep you updated on the progress.
