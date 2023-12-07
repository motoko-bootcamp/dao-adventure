actor {
    // Immutable variable definition in Motoko using 'let'
    let website : Text = "https://motokobootcamp.com";

    // Mutable variable definition in Motoko using 'var'
    var message : Text = "Join the Web3 revolution!";

    // Define a query function in Motoko
    // Query functions are fast (~200ms) since they bypass consensus and don't persist changes
    public query func seeMessage() : async Text {
        return message;
    };

    // Define an update function in Motoko
    // Update functions take longer (~2s) due to consensus requirements
    public func changeMessage(newMessage : Text) : async () {
        message := newMessage;
    };
};
