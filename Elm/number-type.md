#Elm number type

By default when you create an Integer, Elm don't assign immediately a Int type.

```
> y = 3
3 : number
```

Instead a number type is assigned until you cast this number into an Int (adding an Int to a number, or using round 
function for example).

```
> 3 + round 2
5 : Int
```
Or a Float (with toFloat or adding to a float number).

```
> y + 3.0
6 : Float
```


