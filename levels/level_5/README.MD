# Level 5 - Showing your face to the world
## Introduction
It's time! 
You have built the foundational structure for your DAO.
By now, it's time to go public and show your vision to the rest of the world. 

A simple way to do this is to build a website that will allow anyone to see the name, manifesto, goals and some statistics about your DAO. We will also add a logo!
## 🎯 Mission

Yes, canisters are able to serve web content! We will leverage this feature in this level. Your mission, should you choose to accept it, is to implement a simple website that will allow anyone to see the name, manifesto, goals and some statistics about your DAO.

The end result should look like this:

![Motoko Bootcamp Website](https://raw.githubusercontent.com/motoko-bootcamp/dao-adventure/main/levels/assets/level_5/webpage_mbc.png)

### Task 1: Find a logo for your DAO (as an SVG file)
To keep things simple, we will use an SVG file as a logo. SVGs are basically text files that carry vector information about visuals.
For instance here is the Motoko Bootcamp logo as an SVG file:

```svg
<svg width="100%" height="100%" viewBox="0 0 95 95" version="1.1"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve"
    xmlns:serif="http://www.serif.com/" style="fill-rule:evenodd;clip-rule:evenodd;stroke-linejoin:round;stroke-miterlimit:2;">
    <path d="M80.841,13.862C99.324,32.346 99.324,62.358 80.841,80.841C62.358,99.324 32.346,99.324 13.862,80.841C-4.621,62.358 -4.621,32.346 13.862,13.862C32.346,-4.621 62.358,-4.621 80.841,13.862Z" style="fill:#0a0c18;"/>
    <path d="M75.747,18.956C60.075,3.284 34.628,3.284 18.956,18.956C3.284,34.628 3.284,60.075 18.956,75.747C34.628,91.419 60.075,91.419 75.747,75.747C91.419,60.075 91.419,34.628 75.747,18.956Z" style="fill:#fae84e;"/>
    <path d="M41.662,24.176C49.627,16.21 62.562,16.21 70.527,24.176C78.493,32.142 78.493,45.076 70.527,53.042L48.571,74.998C47.324,76.245 45.414,76.542 43.847,75.733C42.281,74.923 41.418,73.193 41.714,71.455L41.715,71.449C41.956,70.034 41.358,68.607 40.182,67.785C39.005,66.963 37.459,66.893 36.213,67.606L29.799,71.278C27.97,72.325 25.666,72.018 24.176,70.527C22.686,69.037 22.378,66.734 23.425,64.905L27.076,58.528C27.789,57.281 27.718,55.733 26.892,54.558C26.066,53.382 24.634,52.79 23.219,53.039L23.211,53.04C21.471,53.346 19.734,52.488 18.919,50.921C18.104,49.354 18.399,47.439 19.648,46.19L41.662,24.176Z" style="fill:#0a0c18;"/>
    <path d="M45.502,29.451C39.25,35.703 38.599,45.203 44.05,50.654C49.5,56.104 59.001,55.454 65.253,49.202C71.505,42.95 72.156,33.449 66.705,27.998C61.255,22.548 51.754,23.199 45.502,29.451Z" style="fill:#fff;"/>
    <path d="M49.774,40.539C50.986,39.328 52.953,39.328 54.164,40.539C55.375,41.751 55.375,43.718 54.164,44.929C52.953,46.141 50.986,46.141 49.774,44.929C48.563,43.718 48.563,41.751 49.774,40.539Z" style="fill:#0a0c18;"/>
    <path d="M59.091,31.222C60.303,30.011 62.27,30.011 63.481,31.222C64.692,32.434 64.692,34.401 63.481,35.612C62.27,36.824 60.303,36.824 59.091,35.612C57.88,34.401 57.88,32.434 59.091,31.222Z" style="fill:#0a0c18;"/>
</svg>
```

Once you've find you logo simply define an immutable variable called `logo` of type `Text` and set it to the value of the SVG file.

### Task 2: Implement an helper function `getInfo`

Before we implement the webpage, we will define an helper function that will return some statistics about the DAO. The `getStats` function return a `DAOInfo` objec that contains the following fields:

- `name`: The name of the DAO.
- `manifesto`: The manifesto of the DAO.
- `goals`: The list of goals of the DAO.
- `logo`: The logo of the DAO, as an SVG file.

### Task 3: Implement the webpage

### Task 3.1: Implement an helper function `_getWebpage`

Before we implement the webpage, we will define an helper function that will return the webpage as a `Text` object. The `_getWebpage` function return a `Text` object that contains the formatted webpage. You can simply copy the following code or implement your own formatting.

```motoko
func _getWebpage() : Text {
    var webpage = "<style>" #
    "body { text-align: center; font-family: Arial, sans-serif; background-color: #f0f8ff; color: #333; }" #
    "h1 { font-size: 3em; margin-bottom: 10px; }" #
    "hr { margin-top: 20px; margin-bottom: 20px; }" #
    "em { font-style: italic; display: block; margin-bottom: 20px; }" #
    "ul { list-style-type: none; padding: 0; }" #
    "li { margin: 10px 0; }" #
    "li:before { content: '👉 '; }" #
    "svg { max-width: 150px; height: auto; display: block; margin: 20px auto; }" #
    "h2 { text-decoration: underline; }" #
    "</style>";

    webpage := webpage # "<div><h1>" # name # "</h1></div>";
    webpage := webpage # "<em>" # manifesto # "</em>";
    webpage := webpage # "<div>" # logo # "</div>";
    webpage := webpage # "<hr>";
    webpage := webpage # "<h2>Our goals:</h2>";
    webpage := webpage # "<ul>";
    for (goal in goals.vals()) {
        webpage := webpage # "<li>" # goal # "</li>";
    };
    webpage := webpage # "</ul>";
    return webpage;
};
```

### Task 3.2: Define the `HttpRequest` and `HttpResponse` types
By leveraging the `http.mo` file that is provided in the `src` folder, define the `HttpRequest` and `HttpResponse` types.

### Task 3.3: Implement the `http_request` query function

In Motoko, to serve a webpage, you simply need to implement a `http_request` query function. This function will be called by the Internet Computer when a user tries to access your webpage.

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

## 📚 Resources
| Name | Type | URL | Description |
| ---- | ---- | --- | ----------- |
| HTTP Request | Lesson | [Chapter 13](https://github.com/motoko-bootcamp/dao-adventure/blob/main/lessons/chapter-13/CHAPTER-13.MD) | Learn how canisters can be directly accessible fron any browser and serve webpages! |