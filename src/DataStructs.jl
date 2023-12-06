using HashCode2014

struct ModifiedJunction
    index::Int
    latitude::Float64
    longitude::Float64
end

function get_modified_junctions(city::City)
    return [ModifiedJunction(i, j.latitude, j.longitude) for (i, j) in enumerate(city.junctions)]
end


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


struct AdjList{T}
    edges::Vector{Vector{T}}
    total_duration::Int
end

function create_adj_list(city::City)
    num_vertices = length(city.junctions)
    edges = [Vector{ModifiedStreet}() for _ in 1:num_vertices]
    modified_streets = get_modified_streets(city)
    for street in modified_streets
        push!(edges[street.A.index], street)
        if !street.bidirectional
            push!(edges[street.B.index], street)
        end
    end
    
    return AdjList(edges, city.total_duration)
end
