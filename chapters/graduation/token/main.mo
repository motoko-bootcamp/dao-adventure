import Result "mo:base/Result";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Map "mo:map/Map";
import Buffer "mo:base/Buffer";
import { phash } "mo:map/Map";
actor MBToken {

  public type Result<A, B> = Result.Result<A, B>;

  let ledger = Map.new<Principal, Nat>();

  public query func tokenName() : async Text {
    return "Motoko Bootcamp Token";
  };

  public query func tokenSymbol() : async Text {
    return "MBT";
  };

  public func mint(owner : Principal, amount : Nat) : async Result<(), Text> {
    let balance = Option.get(Map.get<Principal, Nat>(ledger, phash, owner), 0);
    Map.set<Principal, Nat>(ledger, phash, owner, balance + amount);
    return #ok();
  };

  public func burn(owner : Principal, amount : Nat) : async Result<(), Text> {
    let balance = Option.get(Map.get<Principal, Nat>(ledger, phash, owner), 0);
    if (balance < amount) {
      return #err("Insufficient balance to burn");
    };
    Map.set<Principal, Nat>(ledger, phash, owner, balance - amount);
    return #ok();
  };

  public query func balanceOf(owner : Principal) : async Nat {
    return Option.get(Map.get<Principal, Nat>(ledger, phash, owner), 0);
  };

  public query func balanceOfArray(owners : [Principal]) : async [Nat] {
    var balances = Buffer.Buffer<Nat>(0);
    for (owner in owners.vals()) {
        balances.add(Option.get(Map.get<Principal, Nat>(ledger, phash, owner), 0));
    };
    return Buffer.toArray(balances);
  };

  public query func totalSupply() : async Nat {
    var total = 0;
    for (balance in Map.vals<Principal, Nat>(ledger)) {
      total += balance;
    };
    return total;
  };

  public shared ({ caller }) func transfer(from : Principal, to : Principal, amount : Nat) : async Result<(), Text> {
    let balanceFrom = Option.get(Map.get<Principal, Nat>(ledger, phash, from), 0);
    let balanceTo = Option.get(Map.get<Principal, Nat>(ledger, phash, to), 0);
    if (balanceFrom < amount) {
      return #err("Insufficient balance to transfer");
    };
    Map.set<Principal, Nat>(ledger, phash, from, balanceFrom - amount);
    Map.set<Principal, Nat>(ledger, phash, to, balanceTo + amount);
    return #ok();
  };
};