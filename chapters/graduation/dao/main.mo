import Result "mo:base/Result";
import Text "mo:base/Text";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Types "types";
actor {

        type Result<A, B> = Result.Result<A, B>;
        type Member = Types.Member;
        type ProposalContent = Types.ProposalContent;
        type ProposalId = Types.ProposalId;
        type Proposal = Types.Proposal;
        type Vote = Types.Vote;
        type HttpRequest = Types.HttpRequest;
        type HttpResponse = Types.HttpResponse;

        // The principal of the Webpage canister associated with this DAO canister (needs to be updated with the ID of your Webpage canister)
        stable let canisterIdWebpage : Principal = Principal.fromText("aaaaa-aa");
        stable var manifesto = "Your manifesto";
        stable let name = "Your DAO";
        stable var goals = [];

        // Returns the name of the DAO
        public query func getName() : async Text {
                return "Not implemented";
        };

        // Returns the manifesto of the DAO
        public query func getManifesto() : async Text {
                return "Not implemented";
        };

        // Returns the goals of the DAO
        public query func getGoals() : async [Text] {
                return [];
        };

        // Register a new member in the DAO with the given name and principal of the caller
        // Airdrop 10 MBC tokens to the new member
        // New members are always Student
        // Returns an error if the member already exists
        public shared ({ caller }) func registerMember(member : Member) : async Result<(), Text> {
                return #err("Not implemented");
        };

        // Get the member with the given principal
        // Returns an error if the member does not exist
        public query func getMember(p : Principal) : async Result<Member, Text> {
                return #err("Not implemented");
        };

        // Graduate the student with the given principal
        // Returns an error if the student does not exist or is not a student
        // Returns an error if the caller is not a mentor
        public shared ({ caller }) func graduate(student : Principal) : async Result<(), Text> {
                return #err("Not implemented");
        };

        // Create a new proposal and returns its id
        // Returns an error if the caller is not a mentor or doesn't own at least 1 MBC token
        public shared ({ caller }) func createProposal(content : ProposalContent) : async Result<ProposalId, Text> {
                return #err("Not implemented");
        };

        // Get the proposal with the given id
        // Returns an error if the proposal does not exist
        public query func getProposal(id : ProposalId) : async Result<Proposal, Text> {
                return #err("Not implemented");
        };

        // Returns all the proposals
        public query func getAllProposal() : async [Proposal] {
                return [];
        };

        // Vote for the given proposal
        // Returns an error if the proposal does not exist or the member is not allowed to vote
        public shared ({ caller }) func voteProposal(proposalId : ProposalId, yesOrNo : Bool) : async Result<(), Text> {
                return #err("Not implemented");
        };

        // Returns the Principal ID of the Webpage canister associated with this DAO canister
        public query func getIdWebpage() : async Principal {
                return canisterIdWebpage;
        };

};
