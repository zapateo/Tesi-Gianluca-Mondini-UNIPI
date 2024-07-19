/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

function SegmentsIntersection
    input Real [4] edge1, edge2;
    output Boolean valid;
    output Real [2] intersection;
protected
    Real x1, x2, y1, y2, dx1, dy1, x, y, xB, yB, dx, dy, DET, DETinv, r, s, xi, yi;
    parameter Real DET_TOLERANCE = 0.00000001;
algorithm
    x1 := edge1[1];
    y1 := edge1[2];
    x2 := edge1[3];
    y2 := edge1[4];

    x := edge2[1];
    y := edge2[2];
    xB := edge2[3];
    yB := edge2[4];

    dx1 := x2 - x1;
    dy1 := y2 - y1;

    dx := xB - x;
    dy := yB - y;

    DET := ((-dx1 * dy) + (dy1 * dx));

    if abs(DET) < DET_TOLERANCE then
        valid := false;
        return;
    end if;

    DETinv := 1.0/DET;
    
    r := DETinv * (-dy  * (x-x1) +  dx * (y-y1));
    s := DETinv * (-dy1 * (x-x1) + dx1 * (y-y1));
    xi := (x1 + r*dx1 + x + s*dx)/2.0;
    yi := (y1 + r*dy1 + y + s*dy)/2.0;

    if (IsIncluded(0, 1, r)) and (IsIncluded(0, 1, s)) then
        intersection := {xi, yi};
        valid := true;
        return;
    else
        valid := false;
        return;
    end if;
end SegmentsIntersection;
