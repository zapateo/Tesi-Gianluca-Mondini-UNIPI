/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

function LineToSegment
    input Real [3] line;
    output Real [4] segment;
protected
    parameter Real big = 10000;
    Real a, b, c;
    Real [2] p1, p2;
    Real m, q;
    Real y1, y2;
algorithm
    a := line[1];
    b := line[2];
    c := line[3];

    if b == 0 and (not (a == 0)) then // Retta verticale
        p1 := {-c, big};
        p2 := {-c, -big};
        segment := {p1[1], p1[2], p2[1], p2[2]};
        return;
    else
        m := -a/b;
        q := -c/b;
        y1 := m * (-big) + q;
        y2 := m * (+big) + q;
        segment := {-big, y1, big, y2};
    end if;
end LineToSegment;
