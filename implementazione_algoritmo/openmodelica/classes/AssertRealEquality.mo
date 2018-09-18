function AssertRealEquality
    input Real actual;
    input Real expected;
algorithm
    if CompareReal(actual, expected) then
        return;
    else
        print("\nASSERTION ERROR [REAL EQUALITY]: expected " + String(expected) + " but have " + String(actual) + "\n\n");
        return;
    end if;
end AssertRealEquality;
