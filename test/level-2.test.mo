import main "../levels/level_2/project/main";
import Debug "mo:base/Debug";
import Result "mo:base/Result";
import { test; suite; expect } "mo:test/async";

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
