/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function SegmentSlope
    input Real [4] edge;
    output Real out;
    output Boolean vertical;
protected
    Real dx, dy;
algorithm
    dx := edge[3] - edge[1];
    dy := edge[4] - edge[2];
    if CompareReal(dx, 0.0) then
        vertical := true;
        out := 0;
        return;
    else
        vertical := false;
        out := dy/dx;
        return;
    end if;
end SegmentSlope;
