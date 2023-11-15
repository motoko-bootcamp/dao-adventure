# Level 5 - Showing the DAO to the world

## Introduction

It's showtime! 🎤
You have built the foundational structure for the DAO.
By now, it's time to go public and showcase your vision to the rest of the world. The more public and vocal you are about the DAO, the more people will know about it, the more magic will happen.

A simple way to do this is to build a website that will allow anyone to see the name, manifesto, goals and some statistics about your DAO. We will also add a logo to make things cooler 😎

## 🎯 Mission

Canisters are able to serve web content and websites! We will leverage this feature in this level. Your mission, is to implement a simple website that will allow anyone to see the name, manifesto, goals and some statistics about your DAO. We will do that without using any frontend technology. We will simply use Motoko and some HTML to generate the webpage.

The end result should look something like this:

![Motoko Bootcamp Website](https://raw.githubusercontent.com/motoko-bootcamp/dao-adventure/main/levels/assets/level_5/webpage_mbc.png)

## ✏️ Tasks

1. Select a logo for the DAO. You will need to find a logo that is available as an SVG file. You can use websites like [FlatIcon](https://www.flaticon.com/fr/).

> SVG stands for Scalable Vector Graphics. We will use SVGs because they are basically text files that carry vector information about visuals. This means we don't have to worry about uploading any asset to our canister, we can simply copy the SVG file and paste it directly in our code.

2. Define an immutable variable called `logo` of type `Text` and set it to the value of the SVG file.

> You can copy the content of the SVG file and paste it directly into your code. Ensure that you use single quotes (`) for any quotes within the SVG file and double quotes (") for enclosing the entire text, as Motoko employs double quotes to delineate strings.

To help you move forward, we've defined the following type:

- `DAOInfo` : which represents the information about the DAO. It has the following fields:
  - `name`: A `Text` representing the name of the DAO.
  - `manifesto`: A `Text` representing the manifesto of the DAO.
  - `goals`: An `Array` of `Text` representing the goals of the DAO.
  - `member`: An `Array` of `Text` representing the members of the DAO.
  - `logo`: A `Text` representing the logo of the DAO.
  - `numberOfMembers`: A `Nat` representing the number of members of the DAO.

```motoko
public type DAOInfo = {
    name : Text;
    manifesto : Text;
    goals : [Text];
    member : [Text];
    logo : Text;
    numberOfMembers : Nat;
};
```

3. Implement the function `getStats`. This function takes no parameters and returns a `DAOInfo` object that contains updated information about the DAO.

```motoko
getStats : shared query () -> async DAOInfo;
```

To help you move forward, we've defined an helper function `getWebpage()`. The `_getWebpage` function return a `Text` object that contains the formatted webpage.

> For the first time in this adventure, we're encountering a private function. A private function is a function that is only accessible from within the canister. It cannot be called from outside the canister. It's a convention to prefix the name of a private function with an underscore (`_`).

> You will need to uncomment the `getWebpage()` function in the `main.mo` file to use it.

By leveraging the `http.mo` file that is provided in the `src` folder, we've defined the `HttpRequest` and `HttpResponse` types. In Motoko, to serve a webpage, you simply need to implement a `http_request` query function. This function will be called by the Internet Computer when a user tries to access your webpage.

For instance this is how you would implement a `http_request` query function that serves a simple "Hello World" webpage:

```motoko
public query func http_request(request : HttpRequest) : async HttpResponse {
    let response = {
        body = Text.encodeUtf8("Hello world");
        headers = [("Content-Type", "text/html; charset=UTF-8")];
        status_code = 200 : Nat16;
        streaming_strategy = null
    };
    return(response)
};
```

4. Implement the `http_request` query function. This function takes a `request` of type `HttpRequest` as a parameter and returns a `HttpResponse` object. This function will be used to serve the webpage of your DAO. 

## 📺 Interface

At the end of this level, your canister should implement the following interface:

    ```motoko
    actor {
        getStats : shared query () -> async DAOStats;
        http_request : shared query (request : HttpRequest) -> async HttpResponse;
    }
    ```

## 📚 Resources

| Name         | Type   | URL                                                                                                       | Description                                                                         |
| ------------ | ------ | --------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| HTTP Request | Lesson | [Chapter 13](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-13/CHAPTER-13.MD) | Learn how canisters can be directly accessible fron any browser and serve webpages! |
