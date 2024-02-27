import Principal "mo:base/Principal";
import Time "mo:base/Time";
import Nat "mo:base/Nat";
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

};