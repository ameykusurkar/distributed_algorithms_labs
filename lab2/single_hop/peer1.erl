-module(peer1).
-export([start/0]).

start() ->
  receive
    {Neighbours} -> next(Neighbours, 0)
  end.

next(Neighbours, N) ->
  receive
    {hello} -> 
      case N of
        0     -> [P ! {hello} || P <- Neighbours];
        _Else -> skip
      end,
      next(Neighbours, N+1) 
  after 1000 ->
    io:format("Peer: ~p Messages seen: ~p~n", [self(), N])
  end.

