import Principal "mo:base/Principal";
import Time "mo:base/Time";
module {

    public type Role = {
        #Student;
        #Graduate;
        #Mentor;
    };

    public type Member = {
        name : Text;
        role : Role;
    };

    public type ProposalId = Nat;

    public type ProposalContent = {
        #ChangeManifesto : Text; // Change the manifesto to the provided text
        #AddGoal : Text;
        #AddMentor : Principal; // Upgrade the member to a mentor with the provided principal
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
        id : ProposalId; // The unique identifier of the proposal
        content : ProposalContent; // The content of the proposal
        creator : Principal; // The member who created the proposal
        created : Time.Time; // The time the proposal was created
        executed : ?Time.Time; // The time the proposal was executed or null if not executed
        votes : [Vote]; // The votes on the proposal so far
        voteScore : Int; // The current score of the proposal based on the votes
        status : ProposalStatus; // The current status of the proposal
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