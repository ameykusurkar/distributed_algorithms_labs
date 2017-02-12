
%%% distributed algorithms, n.dulay, 4 jan 17
%%% simple client-server, v1

%%% run all processes on one node
 
-module(system1).
-export([start/0]).
 
start() ->  
  S  = spawn(server, start, []),
  S  ! {bind},
  N = 10,
  [spawn(client, start, []) ! {bind, S} || _ <- lists:seq(1, N)].

