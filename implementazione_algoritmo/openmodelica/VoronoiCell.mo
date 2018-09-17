function voronoi_cell
    input  Real   [:, 4]  input_edges;
    input  Real   [2]     primary_drone;
    input  Real   [:, 2]  other_drones;
    output Real   [:, 4]  output_edges;
protected
    Real   [:, 4]  edges;
    Real   [2]     drone, point, intersect, p1, p2, int1, int2, keep;
    Real   [4]     union_edge, edge_p1_primary_drone, edge_p2_primary_drone, new_edge;
    Real   [3]     perp_bisect;
    Real   [:,2]   intersections;    Real [0,2] empty_intersections;
    Real   [:,4]   new_edges;        Real [0,4] empty_new_edges;
    Boolean have_intersection, have_intersection_1, have_intersection_2, add_to_intersections;
algorithm
    edges := input_edges;
    debug("vado ad effettuare " + String(size(other_drones, 1)) + " iterazioni su other_drones");
    for other_drones_index in 1:size(other_drones, 1) loop drone := other_drones[other_drones_index];
        debug("for other_drones_index in 1:size(other_drones, 1) loop");
        union_edge := {primary_drone[1], primary_drone[2], drone[1], drone[2]};
        perp_bisect := perpendicular_bisector(union_edge);
        intersections := empty_intersections;
        new_edges := empty_new_edges;
        edges := mark_unwanted_edges(edges, primary_drone);
        for i in 1:size(edges, 1) loop
            debug("for i in 1:size(edges, 1) loop");
            if not compare_vectors(edges[i], {-1, -1, -1, -1}) then
                (have_intersection, intersect) := segment_intersection(
                    from_line_to_segment(perp_bisect),
                    edges[i]
                );
                if have_intersection then
                    debug("have_intersection = true");
                    edges[i] := {-1, -1, -1, -1};
                    //----------------------------------------------------------------------
                    p1 := {edges[i, 1], edges[i, 2]};
                    p2 := {edges[i, 3], edges[i, 4]};
                    edge_p1_primary_drone := {p1[1], p1[2], primary_drone[1], primary_drone[2]};
                    edge_p2_primary_drone := {p2[1], p2[2], primary_drone[1], primary_drone[2]};
                    (have_intersection_1, int1) := segment_intersection(
                        from_line_to_segment(perp_bisect),
                        edge_p1_primary_drone
                    );
                    (have_intersection_2, int2) := segment_intersection(
                        from_line_to_segment(perp_bisect),
                        edge_p2_primary_drone
                    );
                    if have_intersection_1 and not have_intersection_2 then
                        debug("Mantengo il punto 'p2'");
                        keep := p2;
                    elseif not have_intersection_1 and have_intersection_2 then
                        debug("Mantengo il punto 'p1'");
                        keep := p1;
                    else
                        assert(false, "non viene creata un intersezione nè con p1 nè con p2");
                    end if;
                    //----------------------------------------------------------------------
                    new_edge := {intersect[1], intersect[2], keep[1], keep[2]};
                    new_edges := cat(1, new_edges, {new_edge});
                    //----------------------------------------------------------------------
                    add_to_intersections := true;
                    for intersections_index in 1:size(intersections, 1) loop
                        if close_value(intersections[intersections_index, 1], intersect[1]) and close_value(intersections[intersections_index, 2], intersect[2]) then
                            add_to_intersections := false;
                        end if;
                    end for;
                    if add_to_intersections then
                        intersections := cat(1, intersections, {intersect});
                    end if;
                end if;
                edges := mark_unwanted_edges(edges, primary_drone);
            end if; // compare_vectors(edges[i], {-1, -1, -1, -1})
        end for; // i in 1:size(edges, 1)
        edges := cat(1, edges, new_edges);
        if size(intersections, 1) == 2 then
            debug("size(intersections, 1) == 2");
            edges := cat(1, edges, {{intersections[1,1], intersections[1,2], intersections[2,1], intersections[2,2]}});
            debug("creato un nuovo bordo");
        end if;
    end for;
    assert(size(edges, 1) > 1, "edges deve contenere almeno un elemento");
    edges := mark_unwanted_edges(edges, primary_drone);
    debug("gli 'edges' sono stati contrassegnati");
    edges := remove_marked_edges(edges);
    debug("gli 'edges' contrassegnati sono stati rimossi");
    edges := remove_duplicated_edges(edges);
    debug("gli 'edges' duplicati sono stati rimossi");
    output_edges := edges;
    return;
end voronoi_cell;

model test_voronoi_cell
    Real [3, 4] edges1;
algorithm
    edges1 := voronoi_cell(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        {25, 25},
        {{75, 75}}
    );
    assert(compare_vectors(edges1[1], {100, 0, 0, 0}), "edges1[1], {100, 0, 0, 0}");
    assert(compare_vectors(edges1[2], {0, 100, 0, 0}), "edges1[2], {0, 100, 0, 0}");
    assert(compare_vectors(edges1[3], {100, 0, 0, 100}), "edges1[3], {100, 0, 0, 100}");
end test_voronoi_cell;
