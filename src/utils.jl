"""
    get_direction(city::City, A::Int, B::Int)

Compute the angle of the street from junction A to junction B in a given city with respect to the north.

# Arguments
- `city::City`: The city object containing the junctions.
- `A::Int`: The index of the starting junction.
- `B::Int`: The index of the destination junction.

# Returns
- The direction in degrees from junction A to junction B.
"""
function get_direction(city::City, A::Int, B::Int)
    a = city.junctions[A]
    b = city.junctions[B]

    lata = deg2rad(a.latitude)
    latb = deg2rad(b.latitude)
    diff_lon = deg2rad(b.longitude - a.longitude)

    x = sin(diff_lon) * cos(latb)
    y = cos(lata) * sin(latb) - (sin(lata) * cos(latb) * cos(diff_lon))

    return (rad2deg(atan(x, y)) + 360) % 360
end


"""
    find_best_spreading_duration(adj_list::AdjList, resolution::Int)

Find the best spreading duration (that achive the highest total distance) for a given problem graph.

# Arguments
- `adj_list::AdjList`: The adjacency list representing the graph.
- `resolution::Int`: The resolution for spreading the duration, i.e. the spreading duration will be incremented by this value at each iteration.

# Returns
- `max_d::Int`: The maximum distance achieved.
- `max_i::Int`: The corresponding spreading duration.

# Raises
- `ArgumentError`: If the resolution is less than or equal to 0, or greater than the total duration.
"""
function find_best_spreading_duration(adj_list::AdjList, resolution::Int)
    max_d = 0
    max_i = 0
    if 0 > resolution > adj_list.total_duration
        raise(ArgumentError("resolution must be larger than 0 and smaller than the total duration"))
    end
    for i in ProgressBar(1:resolution:adj_list.total_duration)
        solution = HashCode2014Solution.solve(adj_list, i)
        d = HashCode2014Solution.total_distance(solution, city)
        
        if d > max_d
            max_d = d
            max_i = i
        end
    end
    return max_d, max_i
end