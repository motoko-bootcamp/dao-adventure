actor {

    public shared query func getName() : async Text {
        return "Not implemented";
    };

    public shared query func getManifesto() : async Text {
        return "Not implemented";
    };

    public func setManifesto(newManifesto : Text) : async () {
        return;
    };

    public func addGoal(newGoal : Text) : async () {
        return;
    };

    public shared query func getGoals() : async [Text] {
        return [];
    };
};