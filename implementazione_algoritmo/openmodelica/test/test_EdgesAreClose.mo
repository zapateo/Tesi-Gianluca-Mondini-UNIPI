model test_EdgesAreClose
protected
    parameter Real [4] e1 = {4.0, 5.0, 1.0, -3.0};
    parameter Real [4] e2 = {4.0, 5.0, 1.0001, -3.0};
    parameter Real [4] e3 = {-4.0, -5.0, 1.0001, -3.0};
equation
    assert(EdgesAreClose(e1, e2), "e1 and e2 should be close");
    assert(not EdgesAreClose(e1, e3), "e1 and e3 should not be close");
end test_EdgesAreClose;
