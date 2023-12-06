using Graphs, SimpleWeightedGraphs

function create_city_graph(city::City)
    streets = city.streets
    sources = Array{Int64, 1}()
    destinations = Array{Int64, 1}()
    durations = Array{Int64, 1}()

    for street in streets
        A, B, duration = street.endpointA, street.endpointB, street.duration
        push!(sources, A)
        push!(destinations, B)
        push!(durations, duration)

        if street.bidirectional
            push!(sources, B)
            push!(destinations, A)
            push!(durations, duration)
        end
    end

    return SimpleWeightedDiGraph(sources, destinations, durations)
end


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

function get_street(city::City, A::Int, B::Int)
    s = filter(
        street -> (street.endpointA == A && street.endpointB == B) || 
        (street.endpointA == B && street.endpointB == A && street.bidirectional), 
        city.streets)[1]
    return s
end

function get_connectivity(city::City, street::Street)
    endpointB = street.endpointB
    connected_streets = filter(s -> s.endpointA == endpointB || (s.endpointB == endpointB && s.bidirectional), city.streets)
    return length(connected_streets)
end


