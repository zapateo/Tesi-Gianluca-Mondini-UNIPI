/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

function EdgesToVertices

    input EdgesArray edges;
    output PointsArray points;

protected

    EdgesArray sorted_edges;
    Integer still_not_sorted, next_index;
    Real [4] last, current, segm;
    Real [2] p1, p2;
    parameter Real [4] NULL = {-101010, -101010, -101010, -101010};

algorithm

    points.len := 0;

    sorted_edges.len := 0;
    sorted_edges := EdgesArrayAppend(sorted_edges, edges.elements[1]);
    edges.elements[1] := NULL;

    still_not_sorted := edges.len - 1;
    while still_not_sorted > 0 loop
        next_index := -1;
        last := sorted_edges.elements[sorted_edges.len];
        for i in 2:edges.len loop
            current := edges.elements[i];
            if CompareVectors(current, NULL) == false then
                if CompareReal(last[3], current[1]) and CompareReal(last[4], current[2]) then
                    next_index := i;
                    p1 := {current[1], current[2]};
                    if still_not_sorted == 1 then
                        p2 := {current[3], current[4]};
                    end if;
                    break;
                end if;
                if CompareReal(last[3], current[3]) and CompareReal(last[4], current[4]) then
                    next_index := i;
                    p1 := {current[3], current[4]};
                    if still_not_sorted == 1 then
                        p2 := {current[1], current[2]};
                    end if;
                    break;
                end if;
                if CompareReal(last[1], current[3]) and CompareReal(last[2], current[4]) then
                    next_index := i;
                    p1 := {current[3], current[4]};
                    if still_not_sorted == 1 then
                        p2 := {current[1], current[2]};
                    end if;
                    break;
                end if;
                if CompareReal(last[1], current[1]) and CompareReal(last[2], current[2]) then
                    next_index := i;
                    p1 := {current[1], current[2]};
                    if still_not_sorted == 1 then
                        p2 := {current[3], current[4]};
                    end if;
                    break;
                end if;
            end if;
        end for;
        assert(not (next_index == -1), "next_index è ancora == -1, questo può significare che la lista 'edges' non contiene segmenti concatenabili tra loro");
        points := PointsArrayAppend(points, p1);
        if still_not_sorted == 1 then
            points := PointsArrayAppend(points, p2);
        end if;
        sorted_edges := EdgesArrayAppend(sorted_edges, edges.elements[next_index]);
        edges.elements[next_index] := NULL;
        still_not_sorted := still_not_sorted - 1;
    end while;
    
end EdgesToVertices;
