/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function CenterOfMass

    input PointsArray points;

    output Real [2] out;

protected

    Real [:, 2] vertices, v_local;
    Real [0, 2] empty_vertices;
    Real x_cent, y_cent, area, factor;

algorithm

    if points.len < 3 then
        out := {-1,-1};
    end if;


    // Adattato da https://stackoverflow.com/a/46937541
    vertices := empty_vertices;
    for i in 1:points.len loop
        vertices := cat(1, vertices, {points.elements[i]});
    end for;

    x_cent := 0;
    y_cent := 0;
    area := 0;

    v_local := cat(1, vertices, {vertices[1]});

    for i in 1:(size(v_local, 1) - 1) loop
        factor := v_local[i,1] * v_local[i+1, 2] - v_local[i+1,1] * v_local[i,2];
        area := area + factor;
        x_cent := x_cent + (v_local[i, 1] + v_local[i+1,1]) * factor;
        y_cent := y_cent + (v_local[i, 2] + v_local[i+1, 2]) * factor;
    end for;

    area := area / 2.0;
    x_cent := x_cent / (area * 6);
    y_cent := y_cent / (area * 6);

    out := {x_cent, y_cent};

end CenterOfMass;
