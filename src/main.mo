import Result "mo:base/Result";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Account "account";
import Buffer "mo:base/Buffer";
import Iter "mo:base/Iter";
import Blob "mo:base/Blob";
import Debug "mo:base/Debug";
import Http "http";
actor class DAO() = this {

    ///////////////
    // LEVEL #1 //
    /////////////

    var manifesto : Text = "Manifesto";
    let goals = Buffer.Buffer<Text>(0);

    public shared query func getName() : async Text {
        return "DAO";
    };

    public shared query func getManifesto() : async Text {
        return manifesto;
    };

    public func setManifesto(newManifesto : Text) : async () {
        manifesto := newManifesto;
        return;
    };

    public func addGoal(newGoal : Text) : async () {
        goals.add(newGoal);
    };

    public shared query func getGoals() : async [Text] {
        return Buffer.toArray(goals);
    };

    ///////////////
    // LEVEL #2 //
    /////////////
    public type Member = {
        name : Text;
        age : Nat;
    };
    public type Result<A, B> = Result.Result<A, B>;
    public type HashMap<A, B> = HashMap.HashMap<A, B>;

    let dao : HashMap<Principal, Member> = HashMap.HashMap<Principal, Member>(0, Principal.equal, Principal.hash);

    public shared ({ caller }) func addMember(member : Member) : async Result<(), Text> {
        switch (dao.get(caller)) {
            case (?member) {
                return #err("Already a member");
            };
            case (null) {
                dao.put(caller, member);
                return #ok(());
            };
        };
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
        return Iter.toArray(dao.vals());
    };

    public query func numberOfMembers() : async Nat {
        return 0;
    };

    ///////////////
    // LEVEL #3 //
    /////////////
    // For this level make sure to use the helpers function in Account.mo

    public type Subaccount = Blob;
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

    ///////////////
    // LEVEL #4 //
    /////////////
    // For this level you need to make use of the code implemented in Level 3

    public type Status = {
        #Open;
        #Accepted;
        #Rejected;
    };

    public type Proposal = {
        id : Nat;
        status : Status;
        manifest : Text;
        votes : Int;
        voters : [Principal];
    };

    public type CreateProposalOk = Nat;

    public type CreateProposalErr = {
        #NotDAOMember;
        #NotEnoughTokens;
        #NotImplemented; // This is just a placeholder - can be removed once you start Level 4
    };

    public type createProposalResult = Result<CreateProposalOk, CreateProposalErr>;

    public type VoteOk = {
        #ProposalAccepted;
        #ProposalRefused;
        #ProposalOpen;
    };

    public type VoteErr = {
        #ProposalNotFound;
        #AlreadyVoted;
        #ProposalEnded;
        #NotImplemented; // This is just a placeholder - can be removed once you start Level 4
    };

    public type voteResult = Result<VoteOk, VoteErr>;

    public shared ({ caller }) func createProposal(manifest : Text) : async createProposalResult {
        return #err(#NotImplemented);
    };

    public query func getProposal(id : Nat) : async ?Proposal {
        return null;
    };

    public shared ({ caller }) func vote(id : Nat, vote : Bool) : async voteResult {
        return #err(#NotImplemented);
    };

    ///////////////
    // LEVEL #5 //
    /////////////

    // func _getWebpage() : Text {
    //     var webpage = "<style>" #
    //     "body { text-align: center; font-family: Arial, sans-serif; background-color: #f0f8ff; color: #333; }" #
    //     "h1 { font-size: 3em; margin-bottom: 10px; }" #
    //     "hr { margin-top: 20px; margin-bottom: 20px; }" #
    //     "em { font-style: italic; display: block; margin-bottom: 20px; }" #
    //     "ul { list-style-type: none; padding: 0; }" #
    //     "li { margin: 10px 0; }" #
    //     "li:before { content: '👉 '; }" #
    //     "svg { max-width: 150px; height: auto; display: block; margin: 20px auto; }" #
    //     "h2 { text-decoration: underline; }" #
    //     "</style>";

    //     webpage := webpage # "<div><h1>" # name # "</h1></div>";
    //     webpage := webpage # "<em>" # manifesto # "</em>";
    //     webpage := webpage # "<div>" # logo # "</div>";
    //     webpage := webpage # "<hr>";
    //     webpage := webpage # "<h2>Our goals:</h2>";
    //     webpage := webpage # "<ul>";
    //     for (goal in goals.vals()) {
    //         webpage := webpage # "<li>" # goal # "</li>";
    //     };
    //     webpage := webpage # "</ul>";
    //     return webpage;
    // };

    public type HttpRequest = Http.Request;
    public type HttpResponse = Http.Response;

    public func http_request(request : HttpRequest) : async HttpResponse {
        return ({
            status_code = 404;
            headers = [];
            body = Blob.fromArray([]);
            streaming_strategy = null;
        });
    };

    //////////////////
    // DO NOT REMOVE /
    /////////////////

    public shared ({ caller }) func whoami() : async Principal {
        return caller;
    };
};
