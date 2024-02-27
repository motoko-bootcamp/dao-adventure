actor Board {
    
    var message : Text = "Motoko Bootcamp will become the best Web3 bootcamp in the world!";
    var counter : Nat = 0;

    public func showMessage(newMessage : Text) : async Text {
        let oldMessage = message;
        message := newMessage;
        counter += 1;
        return oldMessage;
    };

    public query func getNumberMessage() : async Nat {
        return counter;
    };

}