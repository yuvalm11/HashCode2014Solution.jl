include("../src/HashCode2014Solution.jl")

using Test

@testset "HashCode2014Solution.jl" begin
    city = HashCode2014Solution.read_city()
    junctions = city.junctions
    streets = city.streets

    modified_junctions = HashCode2014Solution.get_modified_junctions(city)
    modified_streets = HashCode2014Solution.get_modified_streets(city)

    adj_list = HashCode2014Solution.create_adj_list(city)

    # modified_junctions
    @test length(modified_junctions) == length(junctions)
    @test all([modified_junctions[i].index == i for i in 1:length(junctions)])
    @test all([modified_junctions[i].latitude == j.latitude for (i, j) in enumerate(junctions)])
    @test all([modified_junctions[i].longitude == j.longitude for (i, j) in enumerate(junctions)])

    # modified_streets
    @test length(modified_streets) == length(streets)
    @test all([modified_streets[i].A.index == s.endpointA for (i, s) in enumerate(streets)])
    @test all([modified_streets[i].B.index == s.endpointB for (i, s) in enumerate(streets)])
    @test all([modified_streets[i].bidirectional == s.bidirectional for (i, s) in enumerate(streets)])
    @test all([modified_streets[i].duration == s.duration for (i, s) in enumerate(streets)])
    @test all([modified_streets[i].distance == s.distance for (i, s) in enumerate(streets)])

    # adj_list
    @test length(adj_list.edges) == length(junctions)
    random_street = rand(modified_streets)
    @test random_street in adj_list.edges[random_street.A.index]
    @test (random_street in adj_list.edges[random_street.B.index]) == random_street.bidirectional

    # upper bound
    @test HashCode2014Solution.approx_upper_bound(adj_list, city.nb_cars) <= sum([s.distance for s in streets])
end
