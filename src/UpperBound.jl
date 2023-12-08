using ProgressBars

"""
    approx_upper_bound(adj_list::AdjList)

Approximately calculates the upper bound of the distance traveled by `nb_cars` cars in a given `adj_list` of streets.

The algorithm works as follows:
1. Sort the streets by decreasing speed.
2. For each car, take the fastest street that is not already taken and that does not exceed the total duration of the city.
3. Add the distance of the selected street to the total distance traveled by the cars.
4. Repeat steps 2 and 3 until no street can be taken (either because the total duration is exceeded or because all streets are taken).

The algorithm is not optimal since it does not take into account the connectivity of the streets. 
However, it is fast and gives a good approximation of the upper bound since it is greedily choosing the streets that cover the most
distance in the shortest amount of time without violating the duration constraint.

Correctness:
- The algorithm terminates since the total duration of the city is finite.
- The algorithm is greedy, so it will always choose the street that covers the most distance in the shortest amount of time.
  Therefore, the returned upper bound is always greater than or equal to the actual possible distance traveled by the cars.
- The algorithm does not take into account the connectivity of the streets, so it may not be optimal.

Runtime:
- for s streets, c cars, and j junctions:
- O(s log(s)) for sorting the streets by decreasing speed
- c iterations of the while loop
- O(s) for filtering the streets
- O(1) for the other operations
- Overall runtime: O(s log(s) + c * (s + 1)) = O(s log(s) + c * s)

# Arguments
- `adj_list::AdjList`: The adjacency list representation of the street network.

# Returns
- `distance::Int`: The approximate upper bound of the total distance traveled by the cars.
"""
function approx_upper_bound(adj_list::AdjList)
    streets = adj_list.all_streets
    streets = sort(streets, by=street -> street.speed, rev=true)

    distance = 0
    visited = Set{ModifiedStreet}()
    for c in ProgressBar(1:adj_list.nb_cars)
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