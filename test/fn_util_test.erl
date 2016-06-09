-module(fn_util_test).
-include_lib("eunit/include/eunit.hrl").

multi_adder(A01, A02, A03, A04, A05, A06, A07, A08, A09, A10) ->
    lists:foldl(fun(N, Acc) -> N + Acc end,
		0,
		[A01, A02, A03, A04, A05, A06, A07, A08, A09, A10]).

curried_test() ->
    Cma = fn_util:curried(fun multi_adder/10),
    Cma1 = lists:foldl(fun(N, Cma2) -> Cma2(N) end, Cma, [1,2,3,4,5,6,7,8]),
    ?assert(is_function(Cma1)),
    ?assertMatch({_, _, 1}, fn_util:parts(Cma1)),
    
    R = (Cma1(9))(10),
    ?assertNot(is_function(R)),
    ?assertEqual(55, R).
