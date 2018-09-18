function AssertRealEquality
    input Real actual;
    input Real expected;
algorithm
    if not CompareReal(actual, expected) then
        print("\nASSERTION ERROR [REAL EQUALITY]: expected " + String(expected) + " but have " + String(actual) + "\n\n");
    end if;
end AssertRealEquality;
