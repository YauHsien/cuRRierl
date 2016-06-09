# cuRRierl
Making Erlang fucntions to curry functions

### Usage
Write `Cma = fn_util:curried(fun example:multi_adder/10).` to build a curried function. Then use `Cma1 = lists:foldl(fun(N, Cma2) -> Cma2(N) end, Cma, [1,2,3,4,5,6,7,8]).` to apply arguments to the function `Cma` curriedly.

Write `?assert(true, is_function(Cma1)).` to confirm that `Cma1` is a function.

Write `?assertEqual({_, _, 2}, fn_util:parts(Cma1)).` to confirm the arity of `Cma1`.
