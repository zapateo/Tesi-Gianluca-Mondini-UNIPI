function PointsArrayAppend
    input PointsArray array;
    input Real [2] new_element;
    output PointsArray out;
algorithm
    out := array;
    out.len := out.len + 1;
    out.elements[out.len] := new_element;
end PointsArrayAppend;
