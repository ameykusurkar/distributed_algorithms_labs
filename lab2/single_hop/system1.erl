-module(system1).
-export([start/0]).

start() ->
  N = 10,
  Processes = [spawn(peer1, start, []) || _ <- lists:seq(1, N)],
  [lists:nth(P, Processes) ! {neighbours(P, N, Processes)} || P <- lists:seq(1, N)],
  lists:nth(1, Processes) ! {hello}.

neighbours(P, N, Processes) ->
  case P of
    1     -> [lists:nth(2, Processes)];
    N     -> [lists:nth(P-1, Processes)];
    _Else -> lists:map(fun(X) -> lists:nth(X, Processes) end, [P-1, P+1])
  end.

