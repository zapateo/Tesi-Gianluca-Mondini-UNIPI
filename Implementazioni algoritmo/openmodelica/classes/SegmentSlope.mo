/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

function SegmentSlope
    input Real [4] edge;
    output Real segment_slope;
    output Boolean vertical;
protected
    Real dx, dy;
algorithm
    dx := edge[3] - edge[1];
    dy := edge[4] - edge[2];
    if CompareReal(dx, 0.0) then
        vertical := true;
        segment_slope := 0;
        return;
    else
        vertical := false;
        segment_slope := dy/dx;
        return;
    end if;
end SegmentSlope;
