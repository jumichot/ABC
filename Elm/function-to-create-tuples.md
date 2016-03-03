#Functions for creating tuples

(,), (,,) and (,,,) are actually functions returning tuples.

```
> (,)
<function> : a -> b -> ( a, b )
> (,,)
<function> : a -> b -> c -> ( a, b, c )
> (,,,)
<function> : a -> b -> c -> d -> ( a, b, c, d )
```

So you can call them in a map2 to transform two list into a list of tuple :

```
> List.map2 (,) [0..3] [0..5]
[(0,0),(1,1),(2,2),(3,3)] : List ( number, number' )
```
