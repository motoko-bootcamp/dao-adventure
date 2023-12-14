import Account "account";
import Array "mo:base/Array";
import Result "mo:base/Result";
import TrieMap "mo:base/TrieMap";
import Buffer "mo:base/Buffer";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Trie "mo:base/Trie";
import Option "mo:base/Option";
actor class DAO() {

    // To implement the voting logic in this level you need to make use of the code implemented in previous levels.
    // That's why we bring back the code of the previous levels here.

    // For the logic of this level we need to bring back all the previous levels

    ///////////////
    // LEVEL #1 //
    /////////////

    let name : Text = "Motoko Bootcamp DAO";
    var manifesto : Text = "Empower the next wave of builders to make the Web3 revolution a reality";

    let goals : Buffer.Buffer<Text> = Buffer.Buffer<Text>(0);

    public shared query func getName() : async Text {
        return name;
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
        return;
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
        switch (dao.get(caller)) {
            case (?member) {
                dao.put(caller, member);
                return #ok(());
            };
            case (null) {
                return #err("Not a member");
            };
        };
    };

    public shared ({ caller }) func removeMember() : async Result<(), Text> {
        switch (dao.get(caller)) {
            case (?member) {
                dao.delete(caller);
                return #ok(());
            };
            case (null) {
                return #err("Not a member");
            };
        };
    };

    public query func getMember(p : Principal) : async Result<Member, Text> {
        switch (dao.get(p)) {
            case (?member) {
                return #ok(member);
            };
            case (null) {
                return #err("Not a member");
            };
        };
    };

    public query func getAllMembers() : async [Member] {
        return Iter.toArray(dao.vals());
    };

    public query func numberOfMembers() : async Nat {
        return dao.size();
    };

    ///////////////
    // LEVEL #3 //
    /////////////

    public type Subaccount = Blob;
    public type Account = {
        owner : Principal;
        subaccount : ?Subaccount;
    };

    let nameToken = "Motoko Bootcamp Token";
    let symbolToken = "MBT";

    let ledger : TrieMap.TrieMap<Account, Nat> = TrieMap.TrieMap(Account.accountsEqual, Account.accountsHash);

    public query func tokenName() : async Text {
        return nameToken;
    };

    public query func tokenSymbol() : async Text {
        return symbolToken;
    };

    public func mint(owner : Principal, amount : Nat) : async () {
        let defaultAccount = { owner = owner; subaccount = null };
        switch (ledger.get(defaultAccount)) {
            case (null) {
                ledger.put(defaultAccount, amount);
            };
            case (?some) {
                ledger.put(defaultAccount, some + amount);
            };
        };
        return;
    };

    public shared ({ caller }) func transfer(from : Account, to : Account, amount : Nat) : async Result<(), Text> {
        let fromBalance = switch (ledger.get(from)) {
            case (null) { 0 };
            case (?some) { some };
        };
        if (fromBalance < amount) {
            return #err("Not enough balance");
        };
        let toBalance = switch (ledger.get(to)) {
            case (null) { 0 };
            case (?some) { some };
        };
        ledger.put(from, fromBalance - amount);
        ledger.put(to, toBalance + amount);
        return #ok();
    };

    public query func balanceOf(account : Account) : async Nat {
        return switch (ledger.get(account)) {
            case (null) { 0 };
            case (?some) { some };
        };
    };

    func _balanceOf(account : Account) : Nat {
        return switch (ledger.get(account)) {
            case (null) { 0 };
            case (?some) { some };
        };
    };

    public query func totalSupply() : async Nat {
        var total = 0;
        for (balance in ledger.vals()) {
            total += balance;
        };
        return total;
    };

    // burn the specified amount from the defaultAccount of the specified principal
    // @trap if the defaultAccount has less token than the burned Amount
    func _burnTokens(caller : Principal, burnAmount : Nat) {
        let defaultAccount = { owner = caller; subaccount = null };
        switch (ledger.get(defaultAccount)) {
            case (null) { return };
            case (?some) { ledger.put(defaultAccount, some - burnAmount) };
        };
    };

    ///////////////
    // LEVEL #4 //
    /////////////

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
    };

    public type CreateProposalResult = Result<CreateProposalOk, CreateProposalErr>;

    public type VoteOk = {
        #ProposalAccepted;
        #ProposalRefused;
        #ProposalOpen;
    };

    public type VoteErr = {
        #NotDAOMember;
        #ProposalNotFound;
        #NotEnoughTokens;
        #AlreadyVoted;
        #ProposalEnded;
    };

    public type voteResult = Result<VoteOk, VoteErr>;

    var nextProposalId : Nat = 0;
    let proposals = TrieMap.TrieMap<Nat, Proposal>(Nat.equal, Hash.hash);

    // Returns a boolean indicating if the specified principal is a member of our DAO.
    func _isMemberDAO(p : Principal) : Bool {
        switch (dao.get(p)) {
            case (null) {
                return false;
            };
            case (?member) {
                return true;
            };
        };
    };

    // Returns a boolean indicating if the specified principal has n or more token.
    func _hasEnoughToken(p : Principal, n : Nat) : Bool {
        let defaultAccount : Account = {
            owner = p;
            subaccount = null;
        };
        let balance = _balanceOf(defaultAccount);
        if (n > balance) {
            return false;
        };
        return true;
    };

    public shared ({ caller }) func createProposal(manifest : Text) : async CreateProposalResult {
        // Check that the caller is a member
        if (not (_isMemberDAO(caller))) {
            return #err(#NotDAOMember);
        };
        // Check that the call has enough token
        if (not (_hasEnoughToken(caller, 1))) {
            return #err(#NotEnoughTokens);
        };
        let currentId = nextProposalId;
        let proposal : Proposal = {
            id = currentId;
            status = #Open;
            manifest;
            votes = 0;
            voters = [];
        };
        proposals.put(currentId, proposal);
        _burnTokens(caller, 1);
        nextProposalId += 1;
        return #ok(currentId);
    };

    public query func getProposal(id : Nat) : async ?Proposal {
        return proposals.get(id);
    };

    func _isProposalOpen(proposal : Proposal) : Bool {
        switch (proposal.status) {
            case (#Open) {
                return true;
            };
            case (_) {
                return false;
            };
        };
    };

    func _hasAlreadyVoted(p : Principal, proposal : Proposal) : Bool {
        for (voter in proposal.voters.vals()) {
            if (voter == p) {
                return true;
            };
        };
        return false;
    };

    public shared ({ caller }) func vote(id : Nat, vote : Bool) : async voteResult {
        // Check that the caller is a member
        if (not (_isMemberDAO(caller))) {
            return #err(#NotDAOMember);
        };
        // Check that the caller has enough token
        if (not (_hasEnoughToken(caller, 1))) {
            return #err(#NotEnoughTokens);
        };
        switch (proposals.get(id)) {
            case (null) {
                return #err(#ProposalNotFound);
            };
            case (?proposal) {
                if (not (_isProposalOpen(proposal))) {
                    return #err(#ProposalEnded);
                };
                if (_hasAlreadyVoted(caller, proposal)) {
                    return #err(#AlreadyVoted);
                };

                let newVotes = switch (vote) {
                    case (true) {
                        proposal.votes + 1;
                    };
                    case (false) {
                        proposal.votes - 1;
                    };
                };

                let newStatus = switch (newVotes) {
                    case (10) {
                        #Accepted;
                    };
                    case (-10) {
                        #Rejected;
                    };
                    case (_) {
                        #Open;
                    };
                };

                let newVoters = Array.append<Principal>(proposal.voters, [caller]);

                let newProposal : Proposal = {
                    id = proposal.id;
                    status = newStatus;
                    manifest = proposal.manifest;
                    votes = newVotes;
                    voters = newVoters;
                };

                proposals.put(proposal.id, newProposal);

                let returnValue = switch (newStatus) {
                    case (#Open) {
                        #ProposalOpen;
                    };
                    case (#Accepted) {
                        #ProposalAccepted;
                    };
                    case (#Rejected) {
                        #ProposalRefused;
                    };
                };
                return #ok(returnValue);
            };
        };
    };

};
