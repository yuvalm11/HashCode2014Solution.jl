# Tutorial

## Installation

Since this package is not registered, you can install it by running the following command in the Julia REPL:
```julia
using Pkg
Pkg.add(url="https://github.com/yuvalm11/HashCode2014Solution.jl")
```

## Quick start

The problem instance is represented by the `City` type from [HashCode2014](https://github.com/gdalle/HashCode2014.jl/tree/main). You can read more about it and about other useful data types and functions in the [HashCode2014 documentation](https://gdalle.github.io/HashCode2014.jl/dev/)

This package adds the `AdjList` type, which represents a city as an adjacency list to allow for fast traversal of the city's streets. 

```julia
using HashCode2014Solution

city = read_city()
adj_list = AdjList(city)
```

To get a solution, you can use the `solve` function. It takes an `AdjList` and returns a `Solution` object, which is also defined in `HashCode2014`.

```julia
solution = solve(adj_list)
```
