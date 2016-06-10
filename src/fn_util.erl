-module(fn_util).
-compile(export_all).
-export([curried/1, parts/1]).
-type uncurry() :: function().
-type curry() :: function().

-spec curried(uncurry()) -> curry().
curried(F) ->
    {_M, _F, A} = parts(F),
    curried(F, A, []).

curried(F, A, C) when A == length(C) ->
    apply(F, lists:reverse(C));
curried(F, A, C) when A > length(C) ->
    fun(X) ->
	    curried(F, A, [X|C])
    end.

-spec parts(function()) -> {M :: atom(), F :: atom(), A :: integer()}.
parts(F) when is_function(F) ->
    P = erlang:fun_info(F),
    G = fun proplists:get_value/2,
    [M, F1, A] =
	lists:map(fun([G1, As1]) -> apply(G1, As1) end,
		  [[G, [module, P]],
		   [G, [name, P]],
		   [G, [arity, P]]]),
    {M, F1, A}.
