var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = HashCode2014Solution","category":"page"},{"location":"#HashCode2014Solution","page":"Home","title":"HashCode2014Solution","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for HashCode2014Solution.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [HashCode2014Solution]","category":"page"},{"location":"#HashCode2014Solution.AdjList","page":"Home","title":"HashCode2014Solution.AdjList","text":"struct AdjList{T}\n\nA struct representing an adjacency list.\n\nFields\n\nedges::Vector{Vector{T}}: The adjacency list.\ntotal_duration::Int: The total duration of the city.\nall_streets::Vector{T}: A vector of all modified streets.\n\n\n\n\n\n","category":"type"},{"location":"#HashCode2014Solution.ModifiedJunction","page":"Home","title":"HashCode2014Solution.ModifiedJunction","text":"struct ModifiedJunction\n\nA struct representing a junction. Similar to Junction from HashCode2014,  but with an additional field index representing the index of the junction.\n\nFields\n\nindex::Int: The index of the junction.\nlatitude::Float64: The latitude of the junction.\nlongitude::Float64: The longitude of the junction.\n\n\n\n\n\n","category":"type"},{"location":"#HashCode2014Solution.ModifiedStreet","page":"Home","title":"HashCode2014Solution.ModifiedStreet","text":"struct ModifiedStreet\n\nA struct representing a street. Similar to Street from HashCode2014 but with additional fields.\n\nFields\n\nA::ModifiedJunction: The junction at the first endpoint of the street.\nB::ModifiedJunction: The junction at the second endpoint of the street.\nbidirectional::Bool: Whether the street is bidirectional.\nduration::Int: The duration of the street.\ndistance::Int: The distance of the street.\nangle::Int: The angle of the street with respect to the north.\nspeed::Float16: The speed of the street.\nconnectivity::Int: The number of streets connected to the second endpoint of the street.\n\n\n\n\n\n","category":"type"},{"location":"#HashCode2014Solution.approx_upper_bound-Tuple{AdjList, Int64}","page":"Home","title":"HashCode2014Solution.approx_upper_bound","text":"approx_upper_bound(adj_list::AdjList, nb_cars::Int)\n\nApproximately calculates the upper bound of the distance traveled by nb_cars cars in a given adj_list of streets.\n\nThe algorithm works as follows:\n\nSort the streets by decreasing speed.\nFor each car, take the fastest street that is not already taken and that does not exceed the total duration of the city.\nAdd the distance of the selected street to the total distance traveled by the cars.\nRepeat steps 2 and 3 until no street can be taken (either because the total duration is exceeded or because all streets are taken).\n\nThe algorithm is not optimal since it does not take into account the connectivity of the streets.  However, it is fast and gives a good approximation of the upper bound since it is greedily choosing the streets that cover the most distance in the shortest amount of time without violating the duration constraint.\n\nArguments\n\nadj_list::AdjList: The adjacency list representation of the street network.\nnb_cars::Int: The number of cars.\n\nReturns\n\ndistance::Int: The approximate upper bound of the total distance traveled by the cars.\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Solution.create_adj_list-Tuple{HashCode2014.City}","page":"Home","title":"HashCode2014Solution.create_adj_list","text":"create_adj_list(city::City)\n\nCreate an adjacency list based on the City object.\n\nArguments\n\ncity::City: The City object containing the streets.\n\nReturns\n\nAn AdjList object.\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Solution.get_connectivity-Tuple{HashCode2014.City, HashCode2014.Street}","page":"Home","title":"HashCode2014Solution.get_connectivity","text":"get_connectivity(city::City, street::Street)\n\nReturns the number of streets connected to the endpoint of a given street in a city.\n\nArguments\n\ncity::City: The city object.\nstreet::Street: The street object.\n\nReturns\n\nInt: The number of streets connected to the endpoint of the given street.\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Solution.get_direction-Tuple{HashCode2014.City, Int64, Int64}","page":"Home","title":"HashCode2014Solution.get_direction","text":"get_direction(city::City, A::Int, B::Int)\n\nCompute the angle of the street from junction A to junction B in a given city with respect to the north.\n\nArguments\n\ncity::City: The city object containing the junctions.\nA::Int: The index of the starting junction.\nB::Int: The index of the destination junction.\n\nReturns\n\nThe direction in degrees from junction A to junction B.\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Solution.get_modified_junctions-Tuple{HashCode2014.City}","page":"Home","title":"HashCode2014Solution.get_modified_junctions","text":"get_modified_junctions(city::City)\n\nCreate a list of ModifiedJunction objects based on the City object.\n\nArguments\n\ncity::City: The City object containing the junctions.\n\nReturns\n\nAn array of ModifiedJunction objects.\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Solution.get_modified_streets-Tuple{HashCode2014.City}","page":"Home","title":"HashCode2014Solution.get_modified_streets","text":"get_modified_streets(city::City)\n\nCreate a list of ModifiedStreet objects based on the City object.\n\nArguments\n\ncity::City: The City object containing the streets.\n\nReturns\n\nAn array of ModifiedStreet objects.\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Solution.solve_algorithm-Tuple{}","page":"Home","title":"HashCode2014Solution.solve_algorithm","text":"solve_algorithm()\n\nThis function is used to solve the algorithm.\n\n\n\n\n\n","category":"method"}]
}
