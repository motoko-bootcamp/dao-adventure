import Result "mo:base/Result";
import HashMap "mo:base/HashMap";
import TrieMap "mo:base/TrieMap";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Buffer "mo:base/Buffer";
import Nat64 "mo:base/Nat64";
import Iter "mo:base/Iter";
import Blob "mo:base/Blob";
import Debug "mo:base/Debug";
import Option "mo:base/Option";
import Time "mo:base/Time";
import Array "mo:base/Array";
import Types "types";
actor {
    // For this level we need to make use of the code implemented in the previous projects.
    // The voting system will make use of previous data structures and functions.

    /////////////////
    //   TYPES    //
    ///////////////
    type Member = Types.Member;
    type Result<Ok, Err> = Types.Result<Ok, Err>;
    type HashMap<K, V> = Types.HashMap<K, V>;
    type Proposal = Types.Proposal;
    type ProposalContent = Types.ProposalContent;
    type ProposalId = Types.ProposalId;
    type Vote = Types.Vote;
    type DAOStats = Types.DAOStats;
    type HttpRequest = Types.HttpRequest;
    type HttpResponse = Types.HttpResponse;

    /////////////////
    // PROJECT #1 //
    ///////////////
    let goals = Buffer.Buffer<Text>(0);
    let name = "Motoko Bootcamp";
    var manifesto = "Empower the next generation of builders and make the DAO-revolution a reality";

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
        Buffer.toArray(goals);
    };

    /////////////////
    // PROJECT #2 //
    ///////////////
    let members = HashMap.HashMap<Principal, Member>(0, Principal.equal, Principal.hash);

    public shared ({ caller }) func addMember(member : Member) : async Result<(), Text> {
        switch (members.get(caller)) {
            case (null) {
                members.put(caller, member);
                return #ok();
            };
            case (?member) {
                return #err("Member already exists");
            };
        };
    };

    public shared ({ caller }) func updateMember(member : Member) : async Result<(), Text> {
        switch (members.get(caller)) {
            case (null) {
                return #err("Member does not exist");
            };
            case (?member) {
                members.put(caller, member);
                return #ok();
            };
        };
    };

    public shared ({ caller }) func removeMember() : async Result<(), Text> {
        switch (members.get(caller)) {
            case (null) {
                return #err("Member does not exist");
            };
            case (?member) {
                members.delete(caller);
                return #ok();
            };
        };
    };

    public query func getMember(p : Principal) : async Result<Member, Text> {
        switch (members.get(p)) {
            case (null) {
                return #err("Member does not exist");
            };
            case (?member) {
                return #ok(member);
            };
        };
    };

    public query func getAllMembers() : async [Member] {
        return Iter.toArray(members.vals());
    };

    public query func numberOfMembers() : async Nat {
        return members.size();
    };

    /////////////////
    // PROJECT #3 //
    ///////////////
    let ledger = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

    public query func tokenName() : async Text {
        return "Motoko Bootcamp Token";
    };

    public query func tokenSymbol() : async Text {
        return "MBT";
    };

    public func mint(owner : Principal, amount : Nat) : async Result<(), Text> {
        let balance = Option.get(ledger.get(owner), 0);
        ledger.put(owner, balance + amount);
        return #ok();
    };

    public func burn(owner : Principal, amount : Nat) : async Result<(), Text> {
        let balance = Option.get(ledger.get(owner), 0);
        if (balance < amount) {
            return #err("Insufficient balance to burn");
        };
        ledger.put(owner, balance - amount);
        return #ok();
    };

    func _burn(owner : Principal, amount : Nat) : () {
        let balance = Option.get(ledger.get(owner), 0);
        ledger.put(owner, balance - amount);
        return;
    };

    public shared ({ caller }) func transfer(from : Principal, to : Principal, amount : Nat) : async Result<(), Text> {
        let balanceFrom = Option.get(ledger.get(from), 0);
        let balanceTo = Option.get(ledger.get(to), 0);
        if (balanceFrom < amount) {
            return #err("Insufficient balance to transfer");
        };
        ledger.put(from, balanceFrom - amount);
        ledger.put(to, balanceTo + amount);
        return #ok();
    };

    public query func balanceOf(owner : Principal) : async Nat {
        return (Option.get(ledger.get(owner), 0));
    };

    public query func totalSupply() : async Nat {
        var total = 0;
        for (balance in ledger.vals()) {
            total += balance;
        };
        return total;
    };
    /////////////////
    // PROJECT #4 //
    ///////////////
    var nextProposalId : Nat64 = 0;
    let proposals = HashMap.HashMap<ProposalId, Proposal>(0, Nat64.equal, Nat64.toNat32);

    public shared ({ caller }) func createProposal(content : ProposalContent) : async Result<ProposalId, Text> {
        switch (members.get(caller)) {
            case (null) {
                return #err("The caller is not a member - cannot create a proposal");
            };
            case (?member) {
                let balance = Option.get(ledger.get(caller), 0);
                if (balance < 1) {
                    return #err("The caller does not have enough tokens to create a proposal");
                };
                // Create the proposal and burn the tokens
                let proposal : Proposal = {
                    id = nextProposalId;
                    content;
                    creator = caller;
                    created = Time.now();
                    executed = null;
                    votes = [];
                    voteScore = 0;
                    status = #Open;
                };
                proposals.put(nextProposalId, proposal);
                nextProposalId += 1;
                _burn(caller, 1);
                return #ok(nextProposalId - 1);
            };
        };
    };

    public query func getProposal(proposalId : ProposalId) : async ?Proposal {
        return proposals.get(proposalId);
    };

    public shared ({ caller }) func voteProposal(proposalId : ProposalId, vote : Vote) : async Result<(), Text> {
        // Check if the caller is a member of the DAO
        switch (members.get(caller)) {
            case (null) {
                return #err("The caller is not a member - canno vote one proposal");
            };
            case (?member) {
                // Check if the proposal exists
                switch (proposals.get(proposalId)) {
                    case (null) {
                        return #err("The proposal does not exist");
                    };
                    case (?proposal) {
                        // Check if the proposal is open for voting
                        if (proposal.status != #Open) {
                            return #err("The proposal is not open for voting");
                        };
                        // Check if the caller has already voted
                        if (_hasVoted(proposal, caller)) {
                            return #err("The caller has already voted on this proposal");
                        };
                        let balance = Option.get(ledger.get(caller), 0);
                        let multiplierVote = switch (vote.yesOrNo) {
                            case (true) { 1 };
                            case (false) { -1 };
                        };
                        let newVoteScore = proposal.voteScore + balance * multiplierVote;
                        var newExecuted : ?Time.Time = null;
                        let newVotes = Buffer.fromArray<Vote>(proposal.votes);
                        let newStatus = if (newVoteScore >= 100) {
                            #Accepted;
                        } else if (newVoteScore <= -100) {
                            #Rejected;
                        } else {
                            #Open;
                        };
                        switch (newStatus) {
                            case (#Accepted) {
                                _executeProposal(proposal.content);
                                newExecuted := ?Time.now();
                            };
                            case (_) {};
                        };
                        let newProposal : Proposal = {
                            id = proposal.id;
                            content = proposal.content;
                            creator = proposal.creator;
                            created = proposal.created;
                            executed = newExecuted;
                            votes = Buffer.toArray(newVotes);
                            voteScore = newVoteScore;
                            status = newStatus;
                        };
                        proposals.put(proposal.id, newProposal);
                        return #ok();
                    };
                };
            };
        };
    };

    func _hasVoted(proposal : Proposal, member : Principal) : Bool {
        return Array.find<Vote>(
            proposal.votes,
            func(vote : Vote) {
                return vote.member == member;
            },
        ) != null;
    };

    func _executeProposal(content : ProposalContent) : () {
        switch (content) {
            case (#ChangeManifesto(newManifesto)) {
                manifesto := newManifesto;
            };
            case (#AddGoal(newGoal)) {
                goals.add(newGoal);
            };
        };
        return;
    };

    public query func getAllProposals() : async [Proposal] {
        return Iter.toArray(proposals.vals());
    };

    /////////////////
    // PROJECT #5 //
    ///////////////
    let logo : Text = "<svg width='100%' height='100%' viewBox='0 0 238 60' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' xml:space='preserve' xmlns:serif='http://www.serif.com/' style='fill-rule:evenodd;clip-rule:evenodd;stroke-linejoin:round;stroke-miterlimit:2;'>
    <path d='M92.561,7.748L92.561,26.642L87.959,26.642L87.959,15.984L83.572,26.642L80.154,26.642L75.767,15.984L75.767,26.642L71.165,26.642L71.165,7.748L76.44,7.748L81.876,20.775L87.286,7.748L92.561,7.748ZM99.64,24.085C97.774,22.255 96.841,19.94 96.841,17.141C96.841,14.342 97.778,12.032 99.653,10.211C101.528,8.39 103.825,7.479 106.543,7.479C109.262,7.479 111.549,8.39 113.406,10.211C115.263,12.032 116.192,14.342 116.192,17.141C116.192,19.94 115.259,22.255 113.393,24.085C111.527,25.915 109.239,26.83 106.53,26.83C103.82,26.83 101.524,25.915 99.64,24.085ZM110.136,21.098C111.051,20.111 111.509,18.792 111.509,17.141C111.509,15.49 111.056,14.172 110.15,13.185C109.244,12.198 108.032,11.705 106.516,11.705C105,11.705 103.789,12.198 102.883,13.185C101.977,14.172 101.524,15.49 101.524,17.141C101.524,18.792 101.977,20.111 102.883,21.098C103.789,22.084 105,22.578 106.516,22.578C108.032,22.578 109.239,22.084 110.136,21.098ZM119.206,11.247L119.206,7.748L134.117,7.748L134.117,11.247L128.949,11.247L128.949,26.642L124.347,26.642L124.347,11.247L119.206,11.247ZM139.903,24.085C138.037,22.255 137.104,19.94 137.104,17.141C137.104,14.342 138.042,12.032 139.917,10.211C141.792,8.39 144.088,7.479 146.807,7.479C149.525,7.479 151.813,8.39 153.67,10.211C155.527,12.032 156.455,14.342 156.455,17.141C156.455,19.94 155.522,22.255 153.656,24.085C151.79,25.915 149.503,26.83 146.793,26.83C144.084,26.83 141.787,25.915 139.903,24.085ZM150.4,21.098C151.315,20.111 151.772,18.792 151.772,17.141C151.772,15.49 151.319,14.172 150.413,13.185C149.507,12.198 148.296,11.705 146.78,11.705C145.264,11.705 144.052,12.198 143.146,13.185C142.24,14.172 141.787,15.49 141.787,17.141C141.787,18.792 142.24,20.111 143.146,21.098C144.052,22.084 145.264,22.578 146.78,22.578C148.296,22.578 149.503,22.084 150.4,21.098ZM165.364,26.642L160.762,26.642L160.762,7.748L165.364,7.748L165.364,16.038L171.608,7.748L177.637,7.748L169.859,17.195L177.637,26.642L171.716,26.642L165.364,18.299L165.364,26.642ZM183.181,24.085C181.315,22.255 180.382,19.94 180.382,17.141C180.382,14.342 181.32,12.032 183.195,10.211C185.07,8.39 187.366,7.479 190.085,7.479C192.803,7.479 195.091,8.39 196.948,10.211C198.805,12.032 199.733,14.342 199.733,17.141C199.733,19.94 198.8,22.255 196.934,24.085C195.068,25.915 192.78,26.83 190.071,26.83C187.362,26.83 185.065,25.915 183.181,24.085ZM193.678,21.098C194.593,20.111 195.05,18.792 195.05,17.141C195.05,15.49 194.597,14.172 193.691,13.185C192.785,12.198 191.574,11.705 190.058,11.705C188.541,11.705 187.33,12.198 186.424,13.185C185.518,14.172 185.065,15.49 185.065,17.141C185.065,18.792 185.518,20.111 186.424,21.098C187.33,22.084 188.541,22.578 190.058,22.578C191.574,22.578 192.78,22.084 193.678,21.098Z' style='fill:#0a0c18;'/>
    <path d='M71.165,32.834L79.373,32.834C81.293,32.834 82.823,33.301 83.962,34.234C85.102,35.167 85.671,36.351 85.671,37.787C85.671,39.922 84.424,41.366 81.93,42.12C83.204,42.299 84.218,42.828 84.972,43.708C85.725,44.587 86.102,45.619 86.102,46.803C86.102,48.31 85.55,49.508 84.447,50.396C83.343,51.284 81.805,51.728 79.831,51.728L71.165,51.728L71.165,32.834ZM75.767,36.333L75.767,40.424L78.781,40.424C79.445,40.424 79.979,40.254 80.383,39.913C80.786,39.572 80.988,39.065 80.988,38.392C80.988,37.719 80.786,37.208 80.383,36.858C79.979,36.508 79.445,36.333 78.781,36.333L75.767,36.333ZM75.767,48.229L79.239,48.229C79.867,48.229 80.387,48.041 80.8,47.664C81.213,47.287 81.419,46.767 81.419,46.103C81.419,45.439 81.222,44.91 80.827,44.515C80.432,44.12 79.921,43.923 79.293,43.923L75.767,43.923L75.767,48.229ZM92.346,49.171C90.48,47.341 89.547,45.026 89.547,42.227C89.547,39.428 90.485,37.118 92.36,35.297C94.235,33.476 96.531,32.565 99.25,32.565C101.968,32.565 104.256,33.476 106.113,35.297C107.97,37.118 108.898,39.428 108.898,42.227C108.898,45.026 107.965,47.341 106.099,49.171C104.233,51.001 101.945,51.916 99.236,51.916C96.527,51.916 94.23,51.001 92.346,49.171ZM102.843,46.184C103.758,45.197 104.215,43.878 104.215,42.227C104.215,40.577 103.762,39.258 102.856,38.271C101.95,37.284 100.739,36.791 99.223,36.791C97.706,36.791 96.495,37.284 95.589,38.271C94.683,39.258 94.23,40.577 94.23,42.227C94.23,43.878 94.683,45.197 95.589,46.184C96.495,47.171 97.706,47.664 99.223,47.664C100.739,47.664 101.945,47.171 102.843,46.184ZM114.9,49.171C113.034,47.341 112.101,45.026 112.101,42.227C112.101,39.428 113.039,37.118 114.914,35.297C116.789,33.476 119.085,32.565 121.804,32.565C124.522,32.565 126.81,33.476 128.667,35.297C130.524,37.118 131.452,39.428 131.452,42.227C131.452,45.026 130.519,47.341 128.653,49.171C126.787,51.001 124.499,51.916 121.79,51.916C119.081,51.916 116.784,51.001 114.9,49.171ZM125.397,46.184C126.312,45.197 126.769,43.878 126.769,42.227C126.769,40.577 126.316,39.258 125.41,38.271C124.504,37.284 123.293,36.791 121.777,36.791C120.26,36.791 119.049,37.284 118.143,38.271C117.237,39.258 116.784,40.577 116.784,42.227C116.784,43.878 117.237,45.197 118.143,46.184C119.049,47.171 120.26,47.664 121.777,47.664C123.293,47.664 124.499,47.171 125.397,46.184ZM134.467,36.333L134.467,32.834L149.377,32.834L149.377,36.333L144.209,36.333L144.209,51.728L139.607,51.728L139.607,36.333L134.467,36.333ZM155.164,49.171C153.297,47.341 152.364,45.026 152.364,42.227C152.364,39.428 153.302,37.118 155.177,35.297C157.052,33.476 159.344,32.565 162.054,32.565C164.153,32.565 166.019,33.121 167.652,34.234C169.284,35.346 170.424,36.889 171.07,38.863L165.579,38.863C164.862,37.482 163.713,36.791 162.134,36.791C160.555,36.791 159.313,37.284 158.407,38.271C157.501,39.258 157.048,40.577 157.048,42.227C157.048,43.878 157.501,45.197 158.407,46.184C159.313,47.171 160.555,47.664 162.134,47.664C163.713,47.664 164.862,46.973 165.579,45.592L171.07,45.592C170.424,47.565 169.284,49.108 167.652,50.221C166.019,51.333 164.153,51.89 162.054,51.89C159.344,51.89 157.048,50.983 155.164,49.171ZM187.38,51.728L186.33,48.552L179.548,48.552L178.498,51.728L173.6,51.728L180.167,32.781L185.765,32.781L192.305,51.728L187.38,51.728ZM180.705,45.053L185.173,45.053L182.939,38.325L180.705,45.053ZM217.308,32.834L217.308,51.728L212.706,51.728L212.706,41.07L208.319,51.728L204.901,51.728L200.514,41.07L200.514,51.728L195.911,51.728L195.911,32.834L201.187,32.834L206.623,45.861L212.033,32.834L217.308,32.834ZM237.09,38.621C237.09,39.895 236.632,41.124 235.717,42.308C235.233,42.918 234.511,43.416 233.551,43.802C232.591,44.188 231.456,44.381 230.146,44.381L227.293,44.381L227.293,51.728L222.691,51.728L222.691,32.834L230.146,32.834C232.335,32.834 234.04,33.4 235.26,34.53C236.48,35.66 237.09,37.024 237.09,38.621ZM227.293,40.882L230.146,40.882C230.846,40.882 231.398,40.675 231.801,40.263C232.205,39.85 232.407,39.307 232.407,38.634C232.407,37.962 232.201,37.41 231.788,36.979C231.375,36.549 230.828,36.333 230.146,36.333L227.293,36.333L227.293,40.882Z' style='fill:#0a0c18;'/>
    <path d='M50.701,8.694C62.294,20.286 62.294,39.109 50.701,50.701C39.109,62.294 20.286,62.294 8.694,50.701C-2.898,39.109 -2.898,20.286 8.694,8.694C20.286,-2.898 39.109,-2.898 50.701,8.694Z' style='fill:#0a0c18;'/>
    <path d='M47.507,11.889C37.678,2.06 21.718,2.06 11.889,11.889C2.06,21.718 2.06,37.678 11.889,47.507C21.718,57.336 37.678,57.336 47.507,47.507C57.336,37.678 57.336,21.718 47.507,11.889Z' style='fill:#fae84e;'/>
    <path d='M26.129,15.163C31.125,10.167 39.237,10.167 44.233,15.163C49.229,20.158 49.229,28.271 44.233,33.266L30.462,47.037C29.68,47.819 28.482,48.005 27.5,47.498C26.517,46.99 25.976,45.905 26.162,44.815L26.162,44.811C26.313,43.923 25.939,43.028 25.201,42.513C24.463,41.997 23.493,41.954 22.712,42.401L18.689,44.704C17.542,45.36 16.097,45.168 15.163,44.233C14.228,43.298 14.035,41.854 14.692,40.707L16.981,36.707C17.429,35.925 17.384,34.954 16.866,34.217C16.348,33.48 15.45,33.108 14.562,33.264L14.558,33.265C13.466,33.457 12.377,32.919 11.865,31.936C11.354,30.953 11.539,29.752 12.323,28.969L26.129,15.163Z' style='fill:#0a0c18;'/>
    <path d='M28.538,18.471C24.616,22.392 24.208,28.35 27.627,31.769C31.045,35.187 37.004,34.779 40.925,30.858C44.846,26.937 45.254,20.978 41.836,17.56C38.417,14.141 32.459,14.55 28.538,18.471Z' style='fill:#fff;'/>
    <path d='M37.06,19.582C37.82,18.822 39.054,18.822 39.814,19.582C40.573,20.342 40.573,21.575 39.814,22.335C39.054,23.095 37.82,23.095 37.06,22.335C36.301,21.575 36.301,20.342 37.06,19.582Z' style='fill:#0a0c18;'/>
    <path d='M31.217,25.425C31.977,24.666 33.21,24.666 33.97,25.425C34.73,26.185 34.73,27.419 33.97,28.178C33.21,28.938 31.977,28.938 31.217,28.178C30.457,27.419 30.457,26.185 31.217,25.425Z' style='fill:#0a0c18;'/>
    </svg>";

    func _getWebpage() : Text {
        var webpage = "<style>" #
        "body { text-align: center; font-family: Arial, sans-serif; background-color: #f0f8ff; color: #333; }" #
        "h1 { font-size: 3em; margin-bottom: 10px; }" #
        "hr { margin-top: 20px; margin-bottom: 20px; }" #
        "em { font-style: italic; display: block; margin-bottom: 20px; }" #
        "ul { list-style-type: none; padding: 0; }" #
        "li { margin: 10px 0; }" #
        "li:before { content: '👉 '; }" #
        "svg { max-width: 150px; height: auto; display: block; margin: 20px auto; }" #
        "h2 { text-decoration: underline; }" #
        "</style>";

        webpage := webpage # "<div><h1>" # name # "</h1></div>";
        webpage := webpage # "<em>" # manifesto # "</em>";
        webpage := webpage # "<div>" # logo # "</div>";
        webpage := webpage # "<hr>";
        webpage := webpage # "<h2>Our goals:</h2>";
        webpage := webpage # "<ul>";
        for (goal in goals.vals()) {
            webpage := webpage # "<li>" # goal # "</li>";
        };
        webpage := webpage # "</ul>";
        return webpage;
    };

    public query func getStats() : async DAOStats {
        return ({
            name;
            manifesto;
            goals = Buffer.toArray(goals);
            members = Iter.toArray(Iter.map<Member, Text>(members.vals(), func(member : Member) { member.name }));
            logo;
            numberOfMembers = members.size();
        });
    };

    public query func http_request(request : HttpRequest) : async HttpResponse {
        return ({
            headers = [("Content-Type", "text/html; charset=UTF-8")];
            status_code = 200 : Nat16;
            body = Text.encodeUtf8(_getWebpage());
            streaming_strategy = null;
        });
    };

};