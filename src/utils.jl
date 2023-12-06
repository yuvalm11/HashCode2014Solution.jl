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
    get_connectivity(city::City, street::Street)

Returns the number of streets connected to the endpoint of a given street in a city.

# Arguments
- `city::City`: The city object.
- `street::Street`: The street object.

# Returns
- `Int`: The number of streets connected to the endpoint of the given street.
"""
function get_connectivity(city::City, street::Street)
    endpointB = street.endpointB
    connected_streets = filter(s -> s.endpointA == endpointB || (s.endpointB == endpointB && s.bidirectional), city.streets)
    return length(connected_streets)
end
