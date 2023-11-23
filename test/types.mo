import Result "mo:base/Result";
import HashMap "mo:base/HashMap";
module {

    // Level 2
    public type Member = {
        name : Text;
        age : Nat;
    };
    public type Result<A, B> = Result.Result<A, B>;
    public type HashMap<A, B> = HashMap.HashMap<A, B>;

    // Level 3
    public type Subaccount = Blob;
    public type Account = {
        owner : Principal;
        subaccount : ?Subaccount;
    };

    // Level 4
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
        #NotImplemented; // This is just a placeholder for the template to compile - can be removed
    };

    public type CreateProposalResult = Result<CreateProposalOk, CreateProposalErr>;

    public type VoteOk = {
        #ProposalAccepted;
        #ProposalRefused;
        #ProposalOpen;
    };

    public type VoteErr = {
        #ProposalNotFound;
        #AlreadyVoted;
        #ProposalEnded;
        #NotDAOMember;
        #NotEnoughTokens;
        #NotImplemented; // This is just a placeholder for the template to compile - can be removed
    };

    public type VoteResult = Result<VoteOk, VoteErr>;

    // Level 5
    public type DAOInfo = {
        name : Text;
        manifesto : Text;
        goals : [Text];
        member : [Text];
        logo : Text;
        numberOfMembers : Nat;
    };

};
