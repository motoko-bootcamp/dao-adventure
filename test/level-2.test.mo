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
        await test(
            "updateMember",
            func() : async () {
                let dao = await main.DAO();
                let result = await dao.addMember({ age = 5; name = "test" });
                let result2 = await dao.updateMember({
                    age = 5;
                    name = "modification";
                });
                let members = await dao.getAllMembers();
                assert (members == [{ age = 5; name = "modification" }]);
            },
        );
        await test(
            "removeMember",
            func() : async () {
                let dao = await main.DAO();
                let result = await dao.addMember({ age = 5; name = "test" });
                let result2 = await dao.removeMember();
                let members = await dao.getAllMembers();
                assert (members == []);
            },
        );
        await test(
            "getAllMembers",
            func() : async () {
                let dao = await main.DAO();
                let result = await dao.addMember({ age = 5; name = "test" });
                let members = await dao.getAllMembers();
                assert (members == [{ age = 5; name = "test" }]);
            },
        );
        await test(
            "numberOfMembers",
            func() : async () {
                let dao = await main.DAO();
                let result = await dao.addMember({ age = 5; name = "test" });
                let result2 = await dao.addMember({ age = 5; name = "test2" });
                let members = await dao.numberOfMembers();
                assert (members == 1);
            },
        );
    },
);
