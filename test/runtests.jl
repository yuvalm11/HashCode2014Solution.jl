include("../src/HashCode2014Solution.jl")

using Test

@testset "HashCode2014Solution.jl" begin
    city = HashCode2014Solution.read_city()
    junctions = city.junctions
    streets = city.streets

    modified_junctions = HashCode2014Solution.get_modified_junctions(city)
    modified_streets = HashCode2014Solution.get_modified_streets(city)

    adj_list = HashCode2014Solution.create_adj_list(city)

    @testset "ModifiedJunction" begin
        @test length(modified_junctions) == length(junctions)
        @test all([modified_junctions[i].index == i for i in 1:length(junctions)])
        @test all([modified_junctions[i].latitude == j.latitude for (i, j) in enumerate(junctions)])
        @test all([modified_junctions[i].longitude == j.longitude for (i, j) in enumerate(junctions)])
    end

    @testset "ModifiedStreet" begin
        @test length(modified_streets) == length(streets)
        @test all([modified_streets[i].A.index == s.endpointA for (i, s) in enumerate(streets)])
        @test all([modified_streets[i].B.index == s.endpointB for (i, s) in enumerate(streets)])
        @test all([modified_streets[i].bidirectional == s.bidirectional for (i, s) in enumerate(streets)])
        @test all([modified_streets[i].duration == s.duration for (i, s) in enumerate(streets)])
        @test all([modified_streets[i].distance == s.distance for (i, s) in enumerate(streets)])
    end

    @testset "AdjList" begin
        @test length(adj_list.edges) == length(junctions)
        random_street = rand(modified_streets)
        @test random_street in adj_list.edges[random_street.A.index]
        @test (random_street in adj_list.edges[random_street.B.index]) == random_street.bidirectional
        @test adj_list.total_duration == city.total_duration
        @test adj_list.all_streets == modified_streets
        @test adj_list.nb_cars == city.nb_cars
        @test adj_list.starting_junction == city.starting_junction
    end


    @testset "Upper Bound Approximation" begin
        @test HashCode2014Solution.approx_upper_bound(adj_list) <= sum([s.distance for s in streets])
    end

    @testset "Solve Algorithm" begin
        solution = HashCode2014Solution.solve(adj_list)
        @test length(solution.itineraries) == city.nb_cars
        @test HashCode2014Solution.is_feasible(solution, city)
        @test HashCode2014Solution.total_distance(solution, city) <= HashCode2014Solution.approx_upper_bound(adj_list)
    end
end
