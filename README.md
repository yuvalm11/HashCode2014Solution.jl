# HashCode2014Solution

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://yuvalm11.github.io/HashCode2014Solution.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://yuvalm11.github.io/HashCode2014Solution.jl/dev/)
[![Build Status](https://github.com/yuvalm11/HashCode2014Solution.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/yuvalm11/HashCode2014Solution.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/yuvalm11/HashCode2014Solution.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/yuvalm11/HashCode2014Solution.jl)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)


A solution package for the 2014 Google HashCode competition. 
Built as a final project for MIT's 18.C25 [Solving Real-World Problems with Computation](https://github.com/mitmath/JuliaComputation/tree/Fall23)

Full documentation can be found [here](https://yuvalm11.github.io/HashCode2014Solution.jl/dev/).

The package contains a solution algorithm as well as tools to solve [Google's HashCode 2014 problem](https://storage.googleapis.com/coding-competitions.appspot.com/HC/2014/hashcode2014_final_task.pdf).

The package is an extension of Guillaume Dalle's [HashCode2014](https://github.com/gdalle/HashCode2014.jl/tree/main) package, and uses its data structures and some of its functions as a base.

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


