function solve_algorithm(city::City)
    (; total_duration, nb_cars, starting_junction, streets) = city
    visited_streets = Set{Tuple{Int, Int}}()
    itineraries = Vector{Vector{Int}}(undef, nb_cars)
    g = create_city_graph(city)

    for c in 1:nb_cars
        itinerary = [starting_junction]
        current_junction = last(itinerary)
        duration = 0
        distance = 0
        car_dir = (c-1) * 360/nb_cars
        while distance < 200
            current_junction = last(itinerary)
            neighbors = filter(x -> get_weight(g, current_junction, x) < total_duration - duration, outneighbors(g, current_junction))
            # sort neighbors by absulute difference between direction and car_dir
            neighbors = sort(neighbors, by = x -> abs(get_direction(city, current_junction, x) - car_dir))
            
            if isempty(neighbors)
                break
            end
            
            chosen_neighbor = neighbors[1]

            push!(itinerary, chosen_neighbor)
            push!(visited_streets, (current_junction, chosen_neighbor))
            duration += get_weight(g, current_junction, chosen_neighbor)
            distance = get_street(city, current_junction, chosen_neighbor).distance
        end
        while true
            current_junction = last(itinerary)
            # get neighbors with duration < total_duration - duration
            neighbors = filter(x -> get_weight(g, current_junction, x) < total_duration - duration, outneighbors(g, current_junction))

            unvisited_neighbors = filter(x -> (current_junction, x) ∉ visited_streets, neighbors)
            visited_neighbors = filter(x -> (current_junction, x) ∈ visited_streets, neighbors)
        
            if isempty(unvisited_neighbors)
                if isempty(visited_neighbors)
                    break
                else
                    chosen_neighbor = rand(visited_neighbors)
                end
            else
                chosen_neighbor = rand(unvisited_neighbors)
            end

            push!(itinerary, chosen_neighbor)
            push!(visited_streets, (current_junction, chosen_neighbor))
            duration += get_weight(g, current_junction, chosen_neighbor)
        end
        itineraries[c] = itinerary
    end
    return Solution(itineraries)
end
    