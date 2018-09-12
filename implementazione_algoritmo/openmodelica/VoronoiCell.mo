function voronoi_cell
    input Real [:, 4] edges;
    input Real [2] primary_drone;
    input Real [:, 2] other_drones;
algorithm
    for other_drones_index in 1:size(other_drones, 1) loop
        drone := other_drones[other_drones_index];
        union_edge := {primary_drone[1], primary_drone[2], drone[1], drone[2]};
        perp_bisect := perpendicular_bisector(union_edge);
        //// intersections = []
        //// new_edges = []
        //// edges = mark_unwanted_edges(edges, primary_drone)
        for i in 1:size(edges, 1) loop
            //// if edges[i].to_be_deleted:
            ////   continue
            intersect := segment_intersection(
                from_line_to_segment(perp_bisect),
                edges[i]
            );
            if intersect then
                //// edges[i].to_be_deleted = True
                //----------------------------------------------------------------------
                p1 := {edges[i, 1], edges[i, 2]};
                p2 := {edges[i, 3], edges[i, 4]};
                edge_p1_primary_drone := {p1[1], p1[2], primary_drone[1], primary_drone[2]};
                edge_p2_primary_drone := {p2[1], p2[2], primary_drone[1], primary_drone[2]};
                int1 := segment_intersection(
                    from_line_to_segment(perp_bisect),
                    edge_p1_primary_drone
                );
                int2 := segment_intersection(
                    from_line_to_segment(perp_bisect),
                    edge_p2_primary_drone
                );
                if int1 and not int2 then
                    keep := p2;
                elseif not int1 and int2 then
                    keep := p1;
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
            // edges = mark_unwanted_edges(edges, primary_drone)
        end for;
        edges := cat(1, edges, new_edges);
        if size(intersections, 1) == 2 then
            edges := cat(1, edges, {intersections[1,1], intersections[1,2], intersections[2,1], intersections[2,2]});
        end if;
    end for;
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
