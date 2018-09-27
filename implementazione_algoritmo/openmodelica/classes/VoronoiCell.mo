/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function VoronoiCell

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
    Boolean have_intersection, int1_valid, int2_valid, add_to_intersections;

algorithm

    edges := input_edges;
    for other_drones_index in 1:size(other_drones, 1) loop
        drone := other_drones[other_drones_index];

        union_edge := {primary_drone[1], primary_drone[2], drone[1], drone[2]};
        perp_bisect := PerpendicularBisector(union_edge);
        intersections := empty_intersections;
        new_edges := empty_new_edges;
        edges := MarkUnwantedEdges(edges, primary_drone);

        for i in 1:size(edges, 1) loop

            // Controllo che il segmento non sia gia' stato
            // contrassegnato per essere eliminato
            if not CompareVectors(edges[i], {-1, -1, -1, -1}) then

                (have_intersection, intersect) := SegmentsIntersection(
                    LineToSegment(perp_bisect),
                    edges[i]
                );

                if have_intersection then

                    // Determino quale estremo del segmento mantenere
                    p1 := {edges[i, 1], edges[i, 2]};
                    p2 := {edges[i, 3], edges[i, 4]};
                    edges[i] := {-1, -1, -1, -1};
                    edge_p1_primary_drone := {
                        p1[1], p1[2],
                        primary_drone[1], primary_drone[2]
                    };
                    edge_p2_primary_drone := {
                        p2[1], p2[2],
                        primary_drone[1], primary_drone[2]
                    };
                    (int1_valid, int1) := SegmentsIntersection(
                        LineToSegment(perp_bisect),
                        edge_p1_primary_drone
                    );
                    (int2_valid, int2) := SegmentsIntersection(
                        LineToSegment(perp_bisect),
                        edge_p2_primary_drone
                    );
                    assert(int1_valid or int2_valid, "non viene creata un intersezione ne con p1 ne con p2. p1 = " + VectorToString(p1) + ", p2 = " + VectorToString(p2) + ", primary_drone = " + VectorToString(primary_drone));
                    if int1_valid and not int2_valid then
                        keep := p2;
                    elseif not int1_valid and int2_valid then
                        keep := p1;
                    elseif int1_valid and int2_valid then
                    else
                        assert(false, "errore logico");
                    end if;

                    // Costruisco il nuovo bordo
                    new_edge := {intersect[1], intersect[2], keep[1], keep[2]};
                    new_edges := cat(1, new_edges, {new_edge});

                    // Valuto se aggiungere il nuovo bordo alla lista
                    add_to_intersections := true;
                    for intersections_index in 1:size(intersections, 1) loop
                        if ValuesAreClose(intersections[intersections_index, 1], intersect[1])
                            and ValuesAreClose(intersections[intersections_index, 2], intersect[2]) then
                            add_to_intersections := false;
                        end if;
                    end for;

                    if add_to_intersections then
                        intersections := cat(1, intersections, {intersect});
                    end if;

                end if;

                edges := MarkUnwantedEdges(edges, primary_drone);
            end if;
        end for;
        edges := cat(1, edges, new_edges);

        if size(intersections, 1) == 2 then
            edges := cat(1, edges, {{intersections[1,1], intersections[1,2], intersections[2,1], intersections[2,2]}});
        end if;

    end for;

    assert(size(edges, 1) > 1, "edges deve contenere almeno un elemento");

    edges := MarkUnwantedEdges(edges, primary_drone);
    edges := RemoveMarkedEdges(edges);
    edges := RemoveDuplicatedEdges(edges);

    output_edges := edges;

end VoronoiCell;
