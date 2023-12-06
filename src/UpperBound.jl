"""
    approx_upper_bound(adj_list::AdjList, nb_cars::Int)

Approximately calculates the upper bound of the distance traveled by `nb_cars` cars in a given `adj_list` of streets.

The algorithm works as follows:
1. Sort the streets by decreasing speed.
2. For each car, take the fastest street that is not already taken and that does not exceed the total duration of the city.
3. Add the distance of the selected street to the total distance traveled by the cars.
4. Repeat steps 2 and 3 until no street can be taken (either because the total duration is exceeded or because all streets are taken).

The algorithm is not optimal since it does not take into account the connectivity of the streets. 
However, it is fast and gives a good approximation of the upper bound since it is greedily choosing the streets that cover the most
distance in the shortest amount of time without violating the duration constraint.

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