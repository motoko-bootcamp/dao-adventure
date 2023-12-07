import main "../levels/level_5/project/main";
import Types "types";
import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Option "mo:base/Option";
import Debug "mo:base/Debug";
import Bool "mo:base/Bool";
import Result "mo:base/Result";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import { test; suite; expect } "mo:test/async";
import Account "../src/account";
import Http "../src/http";

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

type Request = Http.Request;
type Response = Http.Response;

type DAOInfo = Types.DAOInfo;

await suite(
    "Level 5",
    func() : async () {
        await test(
            "http_request",
            func() : async () {
                let dao = await main.DAO();
                let httpResponse : Response = await dao.http_request({
                    body = Text.encodeUtf8("");
                    headers = [("Content-Type", "text/html; charset=UTF-8")];
                    method = "GET";
                    url = "/";
                });
            },
        );
        await test(
            "getStats",
            func() : async () {
                let dao = await main.DAO();
                let member = await dao.addMember({ age = 5; name = "test" });
                let daoStats : DAOInfo = await dao.getStats();

                expect.text(daoStats.member[0]).equal("test");
            },
        );
    },
);