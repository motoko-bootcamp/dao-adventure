import main "../levels/level_4/project/main";
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
    "Level 4",
    func() : async () {
        await test(
            "createProposal",
            func() : async () {
                let dao = await main.DAO();
                let member = await dao.addMember({ age = 5; name = "test" });

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
                let member = await dao.addMember({ age = 5; name = "test" });

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
                let member = await dao.addMember({ age = 5; name = "test" });
                
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