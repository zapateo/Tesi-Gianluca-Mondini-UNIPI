function CurrentEdgesSize
    input Real [:,4] vect;
    output Integer current_size;
algorithm
    current_size := 0;
    for i in 1:size(vect, 1) loop
        if not CompareVectors(vect[i], {-101010, -101010, -101010, -101010}) then
            current_size := current_size + 1;
        end if;
    end for;
end CurrentEdgesSize;
