function ValuesAreClose
    input Real a, b;
    output Boolean close;
algorithm
    close := (abs(a - b) < 0.001);
end ValuesAreClose;
