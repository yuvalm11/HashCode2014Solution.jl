"""
    solve(adj_list::AdjList{ModifiedStreet})

Solve the HashCode2014 problem using the algorithm described below.

# Algorithm
This is a greedy algorithm in which we find the best street to take in each iteration. 
To do so, we use a few heuristics:
- Streets that have been visited fewer times in previous iterations are given higher priority.
- Among those, if the car is still in the spreading phase, streets that are directed closer to the car's assigned angle are given higher priority.
  The car's assigned angle is determined by its index in the list of cars: car_angle = car_index * 360/number_of_cars.
- Among those, streets with higher speed are given higher priority.

A street can only be taken if the car will still be able to reach the end of the street before the end of the simulation.
A street cannot be taken if the car is not in the strating end of the street.

# Runtime:
- The acctual runtime is dependent mostly on the total duration of the simulation, but also on the number of cars and the number of streets.
- The algorithm will terminate when the cars cover the total duration of the simulation.

# Arguments
- `adj_list::AdjList{ModifiedStreet}`: The adjacency list.
- `spreading_duration::Int`: The duration for which cars will spread out, i.e. try to stick to streets directed close to an angle corresponding to their index. 
  If not specified, it will be set to 1/10 of the total duration.

# Returns
- A `Solution` object.
"""
function solve(adj_list::AdjList, spreading_duration=-1)
    total_duration = adj_list.total_duration
    nb_cars = adj_list.nb_cars
    streets = adj_list.all_streets
    starting_junction = adj_list.starting_junction
    edges = adj_list.edges

    if spreading_duration == -1
        spreading_duration = Int(total_duration / 10)
    end

    itineraries = Vector{Vector{Int}}([Vector{Int}([starting_junction]) for _ in 1:nb_cars])
    visited = Dict{ModifiedStreet, Int}([street => 0 for street in streets])
    for c in 1:nb_cars
        duration = 0
        car_angle = c * 360/nb_cars
        while true
            current_junction = last(itineraries[c])
            neighbors = edges[current_junction]
            neighbors = [street for street in neighbors if duration + street.duration <= total_duration]

            # sort by decreasing speed
            neighbors = sort(neighbors, by=street -> street.speed, rev=true)
            if duration <= spreading_duration
                # sort by decreasing difference between the street angle and the car angle
                neighbors = sort(neighbors, by=street -> abs(street.angle - car_angle), rev=true)
            end
            # sort by increasing number of times visited
            neighbors = sort(neighbors, by=street -> visited[street])
            
            if isempty(neighbors)
                break
            else
                street = neighbors[1]
                next_junction = street.A.index == current_junction ? street.B.index : street.A.index
                push!(itineraries[c], next_junction)
                visited[street] += 1
                duration += street.duration
            end
        end
    end
    return Solution(itineraries)
end
