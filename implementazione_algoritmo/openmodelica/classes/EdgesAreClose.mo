function EdgesAreClose
    input Real [4] e1, e2;
    output Boolean out;
algorithm
    out := PointsAreClose({e1[1], e1[2]}, {e2[1], e2[2]}) and PointsAreClose({e1[3], e1[4]}, {e2[3], e2[4]});
end EdgesAreClose;
