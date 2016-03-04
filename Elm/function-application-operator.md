#Elm Function application operator

 f <| a is equivalend to f a, except that <| has low binding priority. 
 Therefore, it can be used when we do not want to enclose some expression in parenthesis :

```
flow down (map bar (fibonacciWithIndexes 10))
flow down <| map bar (fibonacciWithIndexes 10)
```
In the second line, since the <| operator has a low binding priority, the expression to its right is calculated first
and its result is used as the argument to the flow down function (which represents a partial application of the flow function).

source : (http://elm-by-example.org/chapter2fibonaccibars.html)[http://elm-by-example.org/chapter2fibonaccibars.html]

