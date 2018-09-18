function Midpoint
    input Real [4] edge;
    output Real [2] out;
protected
    Real xm, ym;
algorithm
    xm := (edge[1] + edge[3])/2;
    ym := (edge[2] + edge[4])/2;
    out[1] := xm;
    out[2] := ym;
end Midpoint;
