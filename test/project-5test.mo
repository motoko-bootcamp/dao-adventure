import main "../days/day_5/project/main";
import Types "types";
import Text "mo:base/Text";
import { test; suite; expect } "mo:test/async";

let daoGlobal = await main.DAO();
type Request = Types.Request;
type Response = Types.Response;
type DAOInfo = Types.DAOInfo;

await suite(
    "Project 5",
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
                let daoInfo : DAOInfo = await dao.getStats();
                expect.nat(daoInfo.numberOfMembers).equal(1);
                expect.text(daoInfo.name).notEqual("Not implemented");
            },
        );
    },
);
