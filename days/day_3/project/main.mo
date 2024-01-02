import Account "account";
import Result "mo:base/Result";
actor class DAO()  {

    // For this level make sure to use the helpers function in Account.mo
    public type Subaccount = Blob;
    public type Result<A,B> = Result.Result<A,B>;
    public type Account = {
        owner : Principal;
        subaccount : ?Subaccount;
    };

    public query func tokenName() : async Text {
        return "Not implemented";
    };

    public query func tokenSymbol() : async Text {
        return "Not implemented";
    };

    public func mint(owner : Principal, amount : Nat) : async () {
        return;
    };

    public shared ({ caller }) func transfer(from : Account, to : Account, amount : Nat) : async Result<(), Text> {
        return #err("Not implemented");
    };

    public query func balanceOf(account : Account) : async Nat {
        return 0;
    };

    public query func totalSupply() : async Nat {
        return 0;
    };

};
