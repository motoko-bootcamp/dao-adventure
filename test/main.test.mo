import main "../src/main";
import Types "types";
import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Option "mo:base/Option";
import Debug "mo:base/Debug";
import Bool "mo:base/Bool";
import Result "mo:base/Result";
import Principal "mo:base/Principal";
import { test; suite; expect } "mo:test/async";
import Account "../src/account";

let daoGlobal = await main.DAO();
type Member = Types.Member;
type Account = Types.Account;
type Status = Types.Status;
type Proposal = Types.Proposal;
type CreateProposalOk = Types.CreateProposalOk;
type CreateProposalErr = Types.CreateProposalErr;
type CreateProposalResult = Types.CreateProposalResult;
type VoteOk = Types.VoteOk;
type VoteErr = Types.VoteErr;
type VoteResult = Types.VoteResult;

await suite(
    "Level 1",
    func() : async () {
        await test(
            "getName",
            func() : async () {
                let name = await daoGlobal.getName();
                expect.text(name).contains("");
            },
        );
        await test(
            "setManifesto & getManifesto",
            func() : async () {
                let dao = await main.DAO();
                await dao.setManifesto("test");
                let manifesto = await dao.getManifesto();
                expect.text(manifesto).equal("test");
            },
        );
        await test(
            "addGoal & getGoals",
            func() : async () {
                let dao = await main.DAO();
                await dao.addGoal("test");
                let goals = await dao.getGoals();
                assert goals == ["test"];
            },
        );
    },
);

await suite(
    "Level 2",
    func() : async () {
        await test(
            "addMember & getMembers",
            func() : async () {
                let dao = await main.DAO();
                let result = await dao.addMember({ age = 5; name = "test" });
                let members = await dao.getAllMembers();
                assert (members == [{ age = 5; name = "test" }]);
                let err = await dao.addMember({ age = 55; name = "test2" });

                // Strange but ok
                type MyRes = Result.Result<(), Text>;
                func show(a : MyRes) : Text {
                    return debug_show (a);
                };
                func equal(a : MyRes, b : MyRes) : Bool {
                    return a == b;
                };
                // We shouldn't be able to add a member since we've already added one
                expect.result<(), Text>(err, show, equal).isErr();
            },
        );
        // await test(
        //     "updateMember",
        //     func() : async () {
        //         let dao = await main.DAO();
        //         let result = await dao.addMember({ age = 5; name = "test" });
        //         let result2 = await dao.updateMember({
        //             age = 5;
        //             name = "modification";
        //         });
        //         let members = await dao.getAllMembers();
        //         assert (members == [{ age = 5; name = "modification" }]);
        //     },
        // );
        // await test(
        //     "removeMember",
        //     func() : async () {
        //         let dao = await main.DAO();
        //         let result = await dao.addMember({ age = 5; name = "test" });
        //         let result2 = await dao.removeMember();
        //         let members = await dao.getAllMembers();
        //         assert (members == []);
        //     },
        // );
        // await test(
        //     "getAllMembers",
        //     func() : async () {
        //         let dao = await main.DAO();
        //         let result = await dao.addMember({ age = 5; name = "test" });
        //         let result2 = await dao.addMember({ age = 5; name = "test2" });
        //         let members = await dao.getAllMembers();
        //         assert (members == [{ age = 5; name = "test" }, { age = 5; name = "test2" }]);
        //     },
        // );
        // await test(
        //     "numberOfMembers",
        //     func() : async () {
        //         let dao = await main.DAO();
        //         let result = await dao.addMember({ age = 5; name = "test" });
        //         let result2 = await dao.addMember({ age = 5; name = "test2" });
        //         let members = await dao.numberOfMembers();
        //         assert (members == 2);
        //     },
        // );
    },
);

await suite(
    "Level 3",
    func() : async () {
        await test(
            "tokeName",
            func() : async () {
                let dao = await main.DAO();
                let tokenName = await dao.tokenName();
                expect.text(tokenName).contains("");
            },
        );
        await test(
            "tokenSymbol",
            func() : async () {
                let dao = await main.DAO();
                let tokenSymbol = await dao.tokenSymbol();
                expect.text(tokenSymbol).contains("");
            },
        );
        await test(
            "balanceOf & mint",
            func() : async () {
                let dao = await main.DAO();
                let principal = Principal.fromText("2ujkt-fujau-bunuv-gt4b6-2s27j-cv5qi-kddkp-jl7m4-wdj3e-bqdrt-qqe");
                let account : Account = {
                    owner = principal;
                    subaccount = null;
                };
                let result = await dao.mint(principal, 5);
                let balance = await dao.balanceOf(account);
                expect.nat(balance).equal(5);
            },
        );
        await test(
            "balanceOf & transfer",
            func() : async () {
                let dao = await main.DAO();
                let principal1 = Principal.fromText("2ujkt-fujau-bunuv-gt4b6-2s27j-cv5qi-kddkp-jl7m4-wdj3e-bqdrt-qqe");
                let principal2 = Principal.fromText("tfkc5-e6jm5-omb3v-aexna-ew3i3-yzh5q-tzb3o-mwgch-tb2yn-fiofq-aqe");
                let account1 : Account = {
                    owner = principal1;
                    subaccount = null;
                };
                let account2 : Account = {
                    owner = principal2;
                    subaccount = null;
                };
                let result = await dao.mint(principal1, 5);
                let result2 = await dao.transfer(account1, account2, 2);
                let balance1 = await dao.balanceOf(account1);
                let balance2 = await dao.balanceOf(account2);
                expect.nat(balance1).equal(3);
                expect.nat(balance2).equal(2);
            },
        );
        await test(
            "totalSupply",
            func() : async () {
                let dao = await main.DAO();
                let principal1 = Principal.fromText("2ujkt-fujau-bunuv-gt4b6-2s27j-cv5qi-kddkp-jl7m4-wdj3e-bqdrt-qqe");
                let principal2 = Principal.fromText("tfkc5-e6jm5-omb3v-aexna-ew3i3-yzh5q-tzb3o-mwgch-tb2yn-fiofq-aqe");
                let account1 : Account = {
                    owner = principal1;
                    subaccount = null;
                };
                let account2 : Account = {
                    owner = principal2;
                    subaccount = null;
                };
                let result = await dao.mint(principal1, 5);
                let result2 = await dao.mint(principal2, 5);
                let totalSupply = await dao.totalSupply();
                expect.nat(totalSupply).equal(10);
            },
        );
    },
);

await suite(
    "Level 4",
    func() : async () {
        await test(
            "createProposal",
            func() : async () {
                let dao = await main.DAO();
                // Should throw an error cause we don't have enough tokens
                let err = await dao.createProposal("This is a test proposal that should be rejected");

                func show(a : CreateProposalResult) : Text {
                    return debug_show (a);
                };
                func equal(a : CreateProposalResult, b : CreateProposalResult) : Bool {
                    return a == b;
                };
                expect.result<CreateProposalOk, CreateProposalErr>(err, show, equal).isErr();
                // Let's mint some token to create a proposal
                let myPrincipal = await dao.whoami();
                let myAccount = { owner = myPrincipal; subaccount = null };
                let result = await dao.mint(myPrincipal, 5);
                let result2 = await dao.createProposal("This is a test proposal that should be accepted");
                expect.result<CreateProposalOk, CreateProposalErr>(result2, show, equal).isOk();
            },
        );
        await test(
            "getProposal",
            func() : async () {
                let dao = await main.DAO();
                // Let's mint some token to create a proposal
                let myPrincipal = await dao.whoami();
                let myAccount = { owner = myPrincipal; subaccount = null };
                let result = await dao.mint(myPrincipal, 5);
                let result2 = await dao.createProposal("This is a test proposal that should be accepted");

                func show(a : CreateProposalResult) : Text {
                    return debug_show (a);
                };
                func equal(a : CreateProposalResult, b : CreateProposalResult) : Bool {
                    return a == b;
                };
                expect.result<CreateProposalOk, CreateProposalErr>(result2, show, equal).isOk();
                let proposalId : Nat = switch (result2) {
                    case (#ok(id)) {
                        id;
                    };
                    case (#err(e)) {
                        assert false;
                        0;
                    };
                };
                let proposal = await dao.getProposal(proposalId);
                switch (proposal) {
                    case (null) {
                        assert false;
                    };
                    case (?proposal) {
                        expect.text(proposal.manifest).equal("This is a test proposal that should be accepted");
                        expect.nat(proposal.id).equal(proposalId);

                    };
                };
            },
        );
        await test(
            "vote",
            func() : async () {
                let dao = await main.DAO();
                // Let's mint one token just o create a proposal
                let myPrincipal = await dao.whoami();
                let myAccount = { owner = myPrincipal; subaccount = null };
                let result = await dao.mint(myPrincipal, 1);
                let result2 = await dao.createProposal("This is a test proposal that should be accepted");

                func show(a : CreateProposalResult) : Text {
                    return debug_show (a);
                };
                func equal(a : CreateProposalResult, b : CreateProposalResult) : Bool {
                    return a == b;
                };
                expect.result<CreateProposalOk, CreateProposalErr>(result2, show, equal).isOk();
                let proposalId : Nat = switch (result2) {
                    case (#ok(id)) {
                        id;
                    };
                    case (#err(e)) {
                        assert false;
                        0;
                    };
                };
                // Let's vote - we don't have enough tokens left so it should throw an error
                let result3 = await dao.vote(proposalId, true);
                 func show2(a : VoteResult) : Text {
                    return debug_show (a);
                };
                func equal2(a : VoteResult, b : VoteResult) : Bool {
                    return a == b;
                };
                expect.result<VoteOk, VoteErr>(result3, show2, equal2).isErr();
                // Let's mint some more tokens and vote again - this time it should work
                let result4 = await dao.mint(myPrincipal, 5);
                let result5 = await dao.vote(proposalId, true);
                expect.result<VoteOk, VoteErr>(result5, show2, equal2).isOk();
            },
        );
    },
);