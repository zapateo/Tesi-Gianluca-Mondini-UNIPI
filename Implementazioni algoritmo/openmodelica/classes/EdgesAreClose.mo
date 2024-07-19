/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

function EdgesAreClose

    input Real [4] e1, e2;

    output Boolean are_close;

algorithm

    are_close :=
        (PointsAreClose({e1[1], e1[2]}, {e2[1], e2[2]}) and PointsAreClose({e1[3], e1[4]}, {e2[3], e2[4]}))
            or
        (PointsAreClose({e1[1], e1[2]}, {e2[3], e2[4]}) and PointsAreClose({e1[3], e1[4]}, {e2[1], e2[2]}));

end EdgesAreClose;
