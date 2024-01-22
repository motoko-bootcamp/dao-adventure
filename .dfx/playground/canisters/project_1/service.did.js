export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'addGoal' : IDL.Func([IDL.Text], [], []),
    'getGoals' : IDL.Func([], [IDL.Vec(IDL.Text)], ['query']),
    'getManifesto' : IDL.Func([], [IDL.Text], ['query']),
    'getName' : IDL.Func([], [IDL.Text], ['query']),
    'setManifesto' : IDL.Func([IDL.Text], [], []),
  });
};
export const init = ({ IDL }) => { return []; };
