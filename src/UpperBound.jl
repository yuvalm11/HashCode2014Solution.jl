"""
    approx_upper_bound(adj_list::AdjList, nb_cars::Int)

Approximately calculates the upper bound of the distance traveled by `nb_cars` cars in a given `adj_list` of streets.

# Arguments
- `adj_list::AdjList`: The adjacency list representation of the street network.
- `nb_cars::Int`: The number of cars.

# Returns
- `distance::Int`: The approximate upper bound of the total distance traveled by the cars.
"""
function approx_upper_bound(adj_list::AdjList, nb_cars::Int)
    streets = adj_list.all_streets
    streets = sort(streets, by=street -> street.speed, rev=true)

    distance = 0
    visited = Set{ModifiedStreet}()
    for c in 1:nb_cars
        @show c
        @show distance
        duration = 0
        while true
            filtered = filter(street -> street.duration + duration <= adj_list.total_duration, streets)
            filtered = filter(street -> street ∉ visited, filtered)
            if isempty(filtered)
                break
            end
            street = filtered[1]
            duration += street.duration
            distance += street.distance
            push!(visited, street)
        end
    end

    return distance
end