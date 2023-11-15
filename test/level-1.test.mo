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