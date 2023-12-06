include("HashCode2014Solution.jl")

using BenchmarkTools


city = HashCode2014Solution.read_city()
# city = HashCode2014Solution.change_duration(city, 18000)
@show city.total_duration

adj_list = HashCode2014Solution.create_adj_list(city)
@show adj_list.total_duration

@show HashCode2014Solution.approx_upper_bound(adj_list, city.nb_cars)

# random_solution = HashCode2014Solution.random_walk(city)
# @show random_solution
# @show HashCode2014Solution.total_distance(random_solution, city)
# @btime HashCode2014Solution.random_walk($city)

# city = HashCode2014Solution.read_city()
# my_solution = HashCode2014Solution.solve_algorithm(city)

# @show my_solution
# @show HashCode2014Solution.total_distance(my_solution, city)
# @show HashCode2014Solution.is_feasible(my_solution, city, verbose = true)

# @btime HashCode2014Solution.solve_algorithm($city)
