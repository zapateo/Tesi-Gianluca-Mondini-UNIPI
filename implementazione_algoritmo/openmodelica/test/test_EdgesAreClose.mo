/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_EdgesAreClose
protected
    parameter Real [4] e1 = {4.0, 5.0, 1.0, -3.0};
    parameter Real [4] e2 = {4.0, 5.0, 1.0001, -3.0};
    parameter Real [4] e3 = {-4.0, -5.0, 1.0001, -3.0};

    parameter Real [4] e1_reversed = {1.0, -3.0, 4.0, 5.0};
    parameter Real [4] e2_reversed = {1.0001, -3.0, 4.0, 5.0};
    parameter Real [4] e3_reversed = {1.0001, -3.0, -4.0, -5.0};
equation
    assert(EdgesAreClose(e1, e2), "e1 and e2 should be close");
    assert(not EdgesAreClose(e1, e3), "e1 and e3 should not be close");

    assert(EdgesAreClose(e1_reversed, e1), "e1 e e1_reversed dovrebbero essere uguali tra loro");
    assert(EdgesAreClose(e2_reversed, e2), "e2 e e2_reversed dovrebbero essere uguali tra loro");
    assert(EdgesAreClose(e3_reversed, e3), "e3 e e3_reversed dovrebbero essere uguali tra loro");

    assert(EdgesAreClose(e1, e2_reversed), "e1 e e2_reversed dovrebbero essere uguali tra loro");
    assert(EdgesAreClose(e2, e1_reversed), "e2 e e1_reversed dovrebbero essere uguali tra loro");

    assert(not EdgesAreClose(e1, e3_reversed), "e1 e e3_reversed non dovrebbero essere uguali tra loro");
    assert(not EdgesAreClose(e3, e1_reversed), "e3 e e1_reversed non dovrebbero essere uguali tra loro");
end test_EdgesAreClose;
