import main "../levels/level_3/project/main";
import Types "types";
import Principal "mo:base/Principal";
import { test; suite; expect } "mo:test/async";

type Account = Types.Account;

await suite(
    "Level 3",
    func() : async () {
        await test(
            "tokeName",
            func() : async () {
                let dao = await main.DAO();
                let tokenName = await dao.tokenName();
                expect.text(tokenName).notEqual("Not implemented");
            },
        );
        await test(
            "tokenSymbol",
            func() : async () {
                let dao = await main.DAO();
                let tokenSymbol = await dao.tokenSymbol();
                expect.text(tokenSymbol).notEqual("Not implemented");
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
