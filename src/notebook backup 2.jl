### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 1e7034c2-9236-11ee-3943-29a63cea39d7
begin
	using Pkg
	Pkg.add(url="https://github.com/gdalle/HashCode2014.jl")
end

# ╔═╡ 6b27d4de-609e-4d04-96a8-a88a9185a68e
begin
	using HashCode2014
	using PythonCall
	using BenchmarkTools
end

# ╔═╡ b2d04dc5-ce64-4af5-9fef-e5235e1ef729
include("HashCode2014Solution.jl")

# ╔═╡ 9ea4b1ba-fe4f-430f-a4e2-080941eec296
begin
	city = HashCode2014Solution.read_city()
	# city = HashCode2014Solution.change_duration(city, 18000)
	my_solution = HashCode2014Solution.solve_algorithm(city)
end

# ╔═╡ cc5ea321-c123-4522-95dc-b32956deea48
HashCode2014Solution.total_distance(my_solution, city)

# ╔═╡ Cell order:
# ╠═1e7034c2-9236-11ee-3943-29a63cea39d7
# ╠═b2d04dc5-ce64-4af5-9fef-e5235e1ef729
# ╠═6b27d4de-609e-4d04-96a8-a88a9185a68e
# ╠═9ea4b1ba-fe4f-430f-a4e2-080941eec296
# ╠═adba5af7-41b1-41bd-9f2f-d631e47e1fe9
# ╠═cc5ea321-c123-4522-95dc-b32956deea48
# ╠═8c027a5a-adec-46f4-ae90-99fbd4836847
