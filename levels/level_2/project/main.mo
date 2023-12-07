import Result "mo:base/Result";
import HashMap "mo:base/HashMap";
actor class DAO() {

    public type Member = {
        name : Text;
        age : Nat;
    };
    public type Result<A, B> = Result.Result<A, B>;
    public type HashMap<A, B> = HashMap.HashMap<A, B>;

    public shared ({ caller }) func addMember(member : Member) : async Result<(), Text> {
        return #err("Not implemented");
    };

    public shared ({ caller }) func updateMember(member : Member) : async Result<(), Text> {
        return #err("Not implemented");
    };

    public shared ({ caller }) func removeMember() : async Result<(), Text> {
        return #err("Not implemented");
    };

    public query func getMember(p : Principal) : async Result<Member, Text> {
        return #err("Not implemented");
    };

    public query func getAllMembers() : async [Member] {
        return [];
    };

    public query func numberOfMembers() : async Nat {
        return 0;
    };

};
