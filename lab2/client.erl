
%%% distributed algorithms, n.dulay, 4 jan 17
%%% simple client-server, v1

-module(client).
-export([start/0]).

start() -> 
  receive 
    {bind, S} -> next(S)
  end.
 
next(S) ->
  case rand:uniform(2) == 1 of
    true  -> S ! {circle, 1.0, self()};
    false -> S ! {square, 1.0, self()}
  end,
  receive 
    {result, Area} -> 
      io:format("Area is ~p, Process: ~p~n", [Area, self()]) 
  end,
  timer:sleep(rand:uniform(10) * 1000), % pause randomly between 1-10 seconds before next request
  next(S).

