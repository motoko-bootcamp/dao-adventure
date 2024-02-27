import Time "mo:base/Time";
import Result "mo:base/Result";
import HashMap "mo:base/HashMap";
module {
    /////////////////
    // PROJECT #2 //
    ///////////////
    public type Result<Ok, Err> = Result.Result<Ok, Err>;
    public type HashMap<Ok, Err> = HashMap.HashMap<Ok, Err>;
    public type Member = {
        name : Text;
        age : Nat;
    };

    /////////////////
    // PROJECT #4 //
    ///////////////
    public type ProposalId = Nat64;
    public type ProposalContent = {
        #ChangeManifesto : Text; // Change the manifesto to the provided text
        #AddGoal : Text; // Add a new goal with the provided text
    };
    public type ProposalStatus = {
        #Open;
        #Accepted;
        #Rejected;
    };
    public type Vote = {
        member : Principal; // The member who voted
        votingPower : Nat;
        yesOrNo : Bool; // true = yes, false = no
    };
    public type Proposal = {
        id : Nat64; // The id of the proposal
        content : ProposalContent; // The content of the proposal
        creator : Principal; // The member who created the proposal
        created : Time.Time; // The time the proposal was created
        executed : ?Time.Time; // The time the proposal was executed or null if not executed
        votes : [Vote]; // The votes on the proposal so far
        voteScore : Int; // A score based on the votes
        status : ProposalStatus; // The current status of the proposal
    };

    /////////////////
    // PROJECT #5 //
    ///////////////
    public type DAOStats = {
        name : Text;
        manifesto : Text;
        goals : [Text];
        members : [Text];
        logo : Text;
        numberOfMembers : Nat;
    };
    public type HeaderField = (Text, Text);
    public type HttpRequest = {
        body : Blob;
        headers : [HeaderField];
        method : Text;
        url : Text;
    };
    public type HttpResponse = {
        body : Blob;
        headers : [HeaderField];
        status_code : Nat16;
        streaming_strategy : ?StreamingStrategy;
    };
    public type StreamingStrategy = {
        #Callback : {
            callback : StreamingCallback;
            token : StreamingCallbackToken;
        };
    };
    public type StreamingCallback = query (StreamingCallbackToken) -> async (StreamingCallbackResponse);
    public type StreamingCallbackToken = {
        content_encoding : Text;
        index : Nat;
        key : Text;
    };
    public type StreamingCallbackResponse = {
        body : Blob;
        token : ?StreamingCallbackToken;
    };
};