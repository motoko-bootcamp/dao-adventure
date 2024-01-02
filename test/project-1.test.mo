import main "../days/day_1/project/main";

import { test; suite; expect } "mo:test/async";

let daoGlobal = await main.DAO();
await suite(
    "Project 1",
    func() : async () {
        await test(
            "getName",
            func() : async () {
                let name = await daoGlobal.getName();
                expect.text(name).notEqual("Not implemented");
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
