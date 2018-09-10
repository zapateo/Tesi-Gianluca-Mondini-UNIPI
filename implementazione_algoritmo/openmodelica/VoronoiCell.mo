/*
def remove_duplicated_edges(edges):
    edges = edges[:]
    temp_edges = []
    for edge in edges:
        insert = True
        for temp_edge in temp_edges:
            if edges_are_close(edge, temp_edge):
                insert = False
        if insert:
            temp_edges.append(edge)
    edges = temp_edges
    return edges
*/

/* function remove_duplicated_edges
  input Edge edges[:];
  output Edge unique_edges[:];
protected
  Boolean insert;
algorithm
  for i in 1:size(edges, 1) loop
    insert := true;
    for j in 1:size(unique_edges, 1) loop
      if edges_are_close(edges[i], unique_edges[j]) then
        insert := false;
      end if;
    end for;
    if insert then
      unique_edges := cat(1, unique_edges, edges[i:i]);
    end if;
  end for;
end remove_duplicated_edges; */

function remove_duplicated_edges
  type R4 = Real[4];
  input R4 edges[:];
  output R4 unique_edges[:];
protected
  Boolean insert;
algorithm
  for i in 1:size(edges, 1) loop
    insert := true;
    for j in 1:size(unique_edges, 1) loop
      /* if edges_are_close(edges[i], unique_edges[j]) then
        insert := false;
      end if; */
      insert := false;
    end for;
    if insert then
      unique_edges := cat(1, unique_edges, edges[i:i]);
    end if;
  end for;
end remove_duplicated_edges;

model test_remove_duplicated_edges
  /* parameter Edge edges[2] = {
    Edge(Point(0, 0), Point(1, 1)),
    Edge(Point(0, 0), Point(1, 1))
  }; */
  type R4 = Real[4];
  parameter R4 edges1[:] = {
    {0, 0, 1, 1},
    {0, 0, 1, 1},
    {0, 0, 1, 3},
    {-3, 0, 1, 1}
  };
  parameter R4 edges2[:] = {
    {0, 0, 1, 1},
    {4, 0, 1, 1},
    {0, 0, 1, 3},
    {-3, 0, 1, 1}
  };
  R4 out1[:];
  /* parameter R4 out1[:] = remove_duplicated_edges(edges1);
  parameter R4 out2[:] = remove_duplicated_edges(edges2); */
equation
  out1 = remove_duplicated_edges(edges1);
  /* debug(String(size(out1, 1))); */
  /* debug(String(size(out2, 1))); */
end test_remove_duplicated_edges;

/* function voronoi_cell
  input Edge edges[];
  input Point primary_drone;
  input Point other_drones[];
  output Edges out;
end voronoi_cell; */
