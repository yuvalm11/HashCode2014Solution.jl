using HashCode2014


"""
    struct ModifiedJunction

A struct representing a junction. Similar to `Junction` from `HashCode2014`, 
but with an additional field `index` representing the index of the junction.

# Fields
- `index::Int`: The index of the junction.
- `latitude::Float64`: The latitude of the junction.
- `longitude::Float64`: The longitude of the junction.
"""
struct ModifiedJunction
    index::Int
    latitude::Float64
    longitude::Float64
end


"""
    get_modified_junctions(city::City)

Create a list of `ModifiedJunction` objects based on the `City` object.

# Arguments
- `city::City`: The `City` object containing the junctions.

# Returns
- An array of `ModifiedJunction` objects.
"""
function get_modified_junctions(city::City)
    return [ModifiedJunction(i, j.latitude, j.longitude) for (i, j) in enumerate(city.junctions)]
end


"""
    struct ModifiedStreet

A struct representing a street. Similar to `Street` from `HashCode2014` but with additional fields.

# Fields
- `A::ModifiedJunction`: The junction at the first endpoint of the street.
- `B::ModifiedJunction`: The junction at the second endpoint of the street.
- `bidirectional::Bool`: Whether the street is bidirectional.
- `duration::Int`: The duration of the street.
- `distance::Int`: The distance of the street.
- `angle::Int`: The angle of the street with respect to the north.
- `speed::Float16`: The speed of the street.
- `connectivity::Int`: The number of streets connected to the second endpoint of the street.
"""
struct ModifiedStreet
    A::ModifiedJunction
    B::ModifiedJunction
    bidirectional::Bool
    duration::Int
    distance::Int
    angle::Int
    speed::Float16
    connectivity::Int
end


"""
    get_modified_streets(city::City)

Create a list of `ModifiedStreet` objects based on the `City` object.

# Arguments
- `city::City`: The `City` object containing the streets.

# Returns
- An array of `ModifiedStreet` objects.
"""
function get_modified_streets(city::City)
    streets = city.streets
    modified_junctions = get_modified_junctions(city)
    return [
        ModifiedStreet(
            modified_junctions[street.endpointA],
            modified_junctions[street.endpointB],
            street.bidirectional,
            street.duration,
            street.distance,
            round(get_direction(city, street.endpointA, street.endpointB)),
            street.distance / street.duration,
            get_connectivity(city, street)
        ) for street in streets
    ]
end


"""
    struct AdjList{T}

A struct representing an adjacency list.

# Fields
- `edges::Vector{Vector{T}}`: The adjacency list.
- `total_duration::Int`: The total duration of the city.
- `all_streets::Vector{T}`: A vector of all modified streets.
- `nb_cars::Int`: The number of cars.
"""
struct AdjList{T}
    edges::Vector{Vector{T}}
    total_duration::Int
    all_streets::Vector{T}
    nb_cars::Int
    starting_junction::Int
    nb_junctions::Int
end


"""
    create_adj_list(city::City)

Create an adjacency list based on the `City` object.

# Arguments
- `city::City`: The `City` object containing the streets.

# Returns
- An `AdjList` object.
"""
function create_adj_list(city::City)
    num_vertices = length(city.junctions)
    edges = [Vector{ModifiedStreet}() for _ in 1:num_vertices]
    modified_streets = get_modified_streets(city)
    for street in modified_streets
        push!(edges[street.A.index], street)
        if street.bidirectional
            push!(edges[street.B.index], street)
        end
    end
    
    return AdjList(edges, city.total_duration, modified_streets, city.nb_cars, city.starting_junction, num_vertices)
end
