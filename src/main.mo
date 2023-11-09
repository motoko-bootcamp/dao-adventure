import Result "mo:base/Result";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Account "account";
import Http "http";
actor {
    ///////////////
    // LEVEL #1 //
    /////////////

    // public shared query func getName() : async Text {

    // };

    // public shared query func getManifesto() : async Text {

    // };

    // public func setManifeto(newManifesto : Text) : async () {

    // };

    // public func addGoal(newGoal : Text) : async () {

    // };

    // public shared query func getGoals() : async [Text] {

    // };

    ///////////////
    // LEVEL #2 //
    /////////////
    public type Member = {
        name : Text;
        age : Nat;
    };
    public type Result<A, B> = Result.Result<A, B>;
    public type HashMap<A, B> = HashMap.HashMap<A, B>;

    // public shared ({ caller }) func addMember(member : Member) : async Result<(), Text> {

    // };

    // public shared ({ caller }) func updateMember(member : Member) : async Result<(), Text> {

    // };

    // public shared ({ caller }) func removeMember(p : Principal) : async Result<(), Text> {

    // };

    // public query func getMember(p : Principal) : async Result<Member, Text> {

    // };

    // public query func getAllMembers() : async [Member] {

    // };

    // public query func numberOfMembers() : async Nat {

    // };

    ///////////////
    // LEVEL #3 //
    /////////////
    // For this level make sure to use the helpers function in Account.mo

    public type Subaccount = Blob;
    public type Account = {
        owner : Principal;
        subaccount : ?Subaccount;
    };

    // public query func name() : async Text {

    // };

    // public query func symbol() : async Text {

    // };

    // public func mint(owner : Principal, amount : Nat) : async () {

    // };

    // public shared ({ caller }) func transfer(from : Account, to : Account, amount : Nat) : async Result<(), Text> {

    // };

    // public query func balanceOf(account : Account) : async Nat {

    // };

    // public query func totalSupply() : async Nat {

    // };

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

    public type createProposalOk = {
        #ProposalCreated : Nat;
    };

    public type createProposalErr = {
        #NotDAOMember;
        #NotEnoughTokens;
    };

    public type voteOk = {
        #ProposalAccepted;
        #ProposalRefused;
        #ProposalOpen;
    };

    public type voteErr = {
        #ProposalNotFound;
        #AlreadyVoted;
        #ProposalEnded;
    };

    public type voteResult = Result<voteOk, voteErr>;

    public type createProposalResult = Result<createProposalOk, createProposalErr>;

    // public shared ({ caller }) func createProposal(manifest : Text) : async createProposalResult {

    // };

    // public query func getProposal(id : Nat) : async ?Proposal {

    // };

    // public shared ({ caller }) func vote(id : Nat, vote : Bool) : async voteResult {

    // };
    ///////////////
    // LEVEL #5 //
    /////////////
    // If you want to insert your SVG as text in Motoko, make sure to replace all double quotes within the SVG code with single quotes.
    // This is necessary because Motoko use double quotes as delimiters.

    public type HttpRequest = Http.Request;
    public type HttpResponse = Http.Response;

    // public func http_request(request : HttpRequest) : async HttpResponse {

    // };
};
