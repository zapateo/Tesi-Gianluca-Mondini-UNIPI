function IsIncluded
    input Real a;
    input Real b;
    input Real x;
    output Boolean included;
algorithm
    if CompareReal(a, x) then
        included := true;
        return;
    elseif CompareReal(b, x) then
        included := true;
        return;
    elseif (a < x) and (x < b) then
        included := true;
        return;
    else
        included := false;
    end if;
end IsIncluded;
