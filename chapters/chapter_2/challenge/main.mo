import Result "mo:base/Result";
import HashMap "mo:base/HashMap";
import Types "types";
actor {

    type Member = Types.Member;
    type Result<Ok, Err> = Types.Result<Ok, Err>;
    type HashMap<K, V> = Types.HashMap<K, V>;

    public shared ({ caller }) func addMember(member : Member) : async Result<(), Text> {
        return #err("Not implemented");
    };

    public query func getMember(p : Principal) : async Result<Member, Text> {
        return #err("Not implemented");
    };

    public shared ({ caller }) func updateMember(member : Member) : async Result<(), Text> {
        return #err("Not implemented");
    };

    public query func getAllMembers() : async [Member] {
        return [];
    };

    public query func numberOfMembers() : async Nat {
        return 0;
    };

    public shared ({ caller }) func removeMember() : async Result<(), Text> {
        return #err("Not implemented");
    };

};