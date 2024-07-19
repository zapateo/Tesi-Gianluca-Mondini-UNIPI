/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

function VoronoiCell

    input  Real [:, 4]  input_edges;
    input  Real [2]     primary_drone;
    input  Real [:, 2]  other_drones;
    output EdgesArray   edges;

protected

    Real [2]     drone, point, intersect, p1, p2, int1, int2, keep;
    Real [4]     union_edge, edge_p1_primary_drone, edge_p2_primary_drone;
    Real [3]     perp_bisect;
    PointsArray  intersections;
    EdgesArray   new_edges;
    Boolean      have_intersection, int1_valid, int2_valid, add_to_intersections;

algorithm

    edges.len := 0;

    // Copio in edges i segmenti contenuti in input_edges
    for iei in 1:size(input_edges, 1) loop
        edges := EdgesArrayAppend(edges, input_edges[iei]);
    end for;

    for other_drones_index in 1:size(other_drones, 1) loop
        drone := other_drones[other_drones_index];

        // Determino il segmento che unisce primary_drone e drone
        union_edge := {primary_drone[1], primary_drone[2], drone[1], drone[2]};

        // Determino la bisettrice di union_edge
        perp_bisect := PerpendicularBisector(union_edge);

        // Svuoto intersections
        intersections.len := 0;

        // Svuoto new_edges
        new_edges.len := 0;

        // Contrassegno i bordi di edges da cancellare
        edges := MarkUnwantedEdges(edges, primary_drone);

        for i in 1:edges.len loop

            // Controllo che il segmento non sia gia' stato contrassegnato per essere eliminato
            if not CompareVectors(edges.elements[i], {-1, -1, -1, -1}) then

                (have_intersection, intersect) := SegmentsIntersection(
                    LineToSegment(perp_bisect),
                    edges.elements[i]
                );

                if have_intersection then

                    // Determino quale estremo del segmento mantenere
                    p1 := {edges.elements[i, 1], edges.elements[i, 2]};
                    p2 := {edges.elements[i, 3], edges.elements[i, 4]};
                    edges.elements[i] := {-1, -1, -1, -1};
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
                    new_edges := EdgesArrayAppend(new_edges, {intersect[1], intersect[2], keep[1], keep[2]});

                    // Valuto se aggiungere il nuovo bordo alla lista
                    // e nel caso lo aggiungo
                    add_to_intersections := true;
                    for intersections_index in 1:intersections.len loop
                        if ValuesAreClose(intersections.elements[intersections_index, 1], intersect[1])
                            and ValuesAreClose(intersections.elements[intersections_index, 2], intersect[2]) then
                            add_to_intersections := false;
                        end if;
                    end for;
                    if add_to_intersections then
                        intersections := PointsArrayAppend(intersections, intersect);
                    end if;

                end if;

                // Contrassegno tutti i bordi contenuti in edges
                // che devono essere cancellati in quanto "oscurati"
                // da altri bordi
                edges := MarkUnwantedEdges(edges, primary_drone);

            end if;
        end for;

        // Aggiungo ad edges tutti i bordi contenuti in new_edges
        for j in 1:new_edges.len loop
            edges := EdgesArrayAppend(edges, new_edges.elements[j]);
        end for;

        // Svuoto new_edges
        new_edges.len := 0;

        // Se ho due punti di intersezione, creo un segmento che li unisce
        // e lo aggiungo a edges
        if intersections.len == 2 then
            edges := EdgesArrayAppend(edges, {intersections.elements[1,1], intersections.elements[1,2], intersections.elements[2,1], intersections.elements[2,2]});
        end if;

    end for;

    assert(edges.len > 1, "edges deve contenere almeno un elemento");

    edges := MarkUnwantedEdges(edges, primary_drone);
    edges := RemoveMarkedEdges(edges);
    edges := RemoveDuplicatedEdges(edges);

end VoronoiCell;
