import Result "mo:base/Result";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Types "types";
actor {

    type Result<Ok, Err> = Types.Result<Ok, Err>;
    type HashMap<K, V> = Types.HashMap<K, V>;

    public query func tokenName() : async Text {
        return "Not implemented";
    };

    public query func tokenSymbol() : async Text {
        return "Not implemented";
    };

    public func mint(owner : Principal, amount : Nat) : async Result<(), Text> {
        return #err("Not implemented");
    };

    public func burn(owner : Principal, amount : Nat) : async Result<(), Text> {
        return #err("Not implemented");
    };

    public shared ({ caller }) func transfer(from : Principal, to : Principal, amount : Nat) : async Result<(), Text> {
        return #err("Not implemented");
    };

    public query func balanceOf(account : Principal) : async Nat {
        return 0;
    };

    public query func totalSupply() : async Nat {
        return 0;
    };

};