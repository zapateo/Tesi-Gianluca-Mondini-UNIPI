/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function EdgesToVertices

    input EdgesArray edges;
    output PointsArray points;

protected

    Boolean add_p1, add_p2;
    Real [2] p1, p2, point;

algorithm

    points.len := 0;
    for i in 1:edges.len loop

        p1 := {edges.elements[i, 1], edges.elements[i, 2]};
        p2 := {edges.elements[i, 3], edges.elements[i, 4]};
        add_p1 := true;
        add_p2 := true;
        for points_index in 1:points.len loop
            point := points.elements[points_index];
            if PointsAreClose(p1, point) then
                add_p1 := false;
            end if;
            if PointsAreClose(p2, point) then
                add_p2 := false;
            end if;
        end for;
        if add_p1 then
            points := PointsArrayAppend(points, p1);
        end if;
        if add_p2 then
            points := PointsArrayAppend(points, p2);
        end if;

    end for;

end EdgesToVertices;
