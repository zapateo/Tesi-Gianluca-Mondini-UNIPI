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

    output Real   [100, 4]  output_edges;

protected

    Real   [100, 4]  edges;
    Integer edges_size;

    Real   [2]     drone, point, intersect, p1, p2, int1, int2, keep;
    Real   [4]     union_edge, edge_p1_primary_drone, edge_p2_primary_drone;
    Real   [3]     perp_bisect;

    Real   [2,2]   intersections;
    Integer intersections_size;

    Real   [100,4]   new_edges;
    Integer new_edges_size;

    Boolean have_intersection, int1_valid, int2_valid, add_to_intersections;

algorithm

    // Inizializzo edges riempiendolo di "segmenti nulli"
    edges := fill({-101010,-101010,-101010,-101010}, 100);
    edges_size := 0;

    // Copio in edges i segmenti contenuti in input_edges
    for iei in 1:size(input_edges, 1) loop
        edges_size := edges_size + 1;
        edges[edges_size] := input_edges[iei];
    end for;

    for other_drones_index in 1:size(other_drones, 1) loop
        drone := other_drones[other_drones_index];

        // Determino il segmento che unisce primary_drone e drone
        union_edge := {primary_drone[1], primary_drone[2], drone[1], drone[2]};

        // Determino la bisettrice di union_edge
        perp_bisect := PerpendicularBisector(union_edge);

        // Svuoto intersections
        intersections := {{-101010, -101010}, {-101010, -101010}};
        intersections_size := 0;

        // Svuoto new_edges
        new_edges := fill({-101010, -101010, -101010, -101010}, 100);
        new_edges_size := 0;

        // Contrassegno i bordi di new_edges da cancellare
        edges := MarkUnwantedEdges(edges, primary_drone);
        edges_size := CurrentEdgesSize(edges);

        for i in 1:edges_size loop

            // Controllo che il segmento non sia gia' stato contrassegnato per essere eliminato
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
                    new_edges_size := new_edges_size + 1;
                    new_edges[new_edges_size] := {intersect[1], intersect[2], keep[1], keep[2]};

                    // Valuto se aggiungere il nuovo bordo alla lista
                    // e nel caso lo aggiungo
                    add_to_intersections := true;
                    for intersections_index in 1:intersections_size loop
                        if ValuesAreClose(intersections[intersections_index, 1], intersect[1])
                            and ValuesAreClose(intersections[intersections_index, 2], intersect[2]) then
                            add_to_intersections := false;
                        end if;
                    end for;
                    if add_to_intersections then
                        intersections_size := intersections_size + 1;
                        intersections[intersections_size] := intersect;
                    end if;

                end if;

                // Contrassegno tutti i bordi contenuti in edges
                // che devono essere cancellati in quanto "oscurati"
                // da altri bordi
                edges := MarkUnwantedEdges(edges, primary_drone);
                edges_size := CurrentEdgesSize(edges);

            end if;
        end for;

        // Aggiungo ad edges tutti i bordi contenuti in new_edges
        for j in 1:new_edges_size loop
            edges_size := edges_size + 1;
            edges[edges_size] := new_edges[j];
        end for;

        // Svuoto new_edges
        new_edges := fill({-101010, -101010,-101010,-101010}, 100);
        new_edges_size := 0;

        // Se ho due punti di intersezione, creo un segmento che li unisce
        // e lo aggiungo a edges
        if intersections_size == 2 then
            edges_size := edges_size + 1;
            edges[edges_size] := {intersections[1,1], intersections[1,2], intersections[2,1], intersections[2,2]};
        end if;

    end for;

    assert(edges_size > 1, "edges deve contenere almeno un elemento");

    // Contrassegno i bordi contenuti in edges per essere cancellati
    edges := MarkUnwantedEdges(edges, primary_drone);
    edges_size := CurrentEdgesSize(edges);

    // Rimuovo da edges i segmenti contrassegnati
    edges := RemoveMarkedEdges(edges);
    edges_size := CurrentEdgesSize(edges);

    // Rimuovo da edges i segmenti duplicati
    edges := RemoveDuplicatedEdges(edges);
    edges_size := CurrentEdgesSize(edges);


    output_edges := edges;

end VoronoiCell;
