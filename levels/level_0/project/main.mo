actor {

    // Task #1:
    // Create an immutable variable 'name' of type 'Text'.
    // Initialize it with your name.
    let name = "MARCELA MM";

    // Task #2:
    // Create a mutable variable 'message' of type 'Text'.
    // Initialize it with the value of the message you want to share with the world.
    var message: Text = "SOY EXITOSA Y CAPAZ";

    // Task #3:
    // Define a query function 'getName'.
    // This function should return the value of the 'name' variable.
     public query func getName() : async Text {
        return name;
    };

    // Task #4:
    // Define an update function 'setMessage'.
    // This function should update the 'message' variable with the value passed as its argument.
       public func setMessage(newMessage : Text) : async () {
        message := newMessage;
    };

    // Task #5:
    // Define a query function 'getMessage'
    // This function should return the value of the 'message' variable.
     public query func getMessage() : async Text {
        return message;
    };

    // To complete this level - deploy your application and submit it on motokobootcamp.com (Level 0).
    // After that you'll get access to our private OpenChat group and your name will be on the Digital Legacy Scroll forever.

};
