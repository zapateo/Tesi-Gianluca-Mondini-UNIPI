import pygame

import geometria

def find_voronoi_cell(edges, primary_site, other_sites):
    # Step 1
    for site in other_sites:
        # Step 2
        union_edge = Edge(primary_site, site)
        # Step 3
        perp_bisect = perpendicular_bisector(union_edge)
        # Step 4
        intersections = []
        # Step 5
        for edge in edges:
            # Step 6
            intersect = segment_intersection(
                from_line_to_segment(perp_bisect),
                edge
            )
            # Step 7
            if intersect:
                # Step 8
                edge.to_be_deleted = True
                # Step 9
                p1 = edge.start
                p2 = edge.end
                edge_p1_primary_site = Edge(p1, primary_site)
                edge_p2_primary_site = Edge(p2, primary_site)
                int1 = segment_intersection(
                    from_line_to_segment(perp_bisect),
                    edge_p1_primary_site
                )
                int2 = segment_intersection(
                    from_line_to_segment(perp_bisect),
                    edge_p2_primary_site
                )
                if int1 and not int2:
                    keep = p1
                elif not int1 and int2:
                    keep = p2
                else:
                    raise Exception()

if __name__ == "__main__":
    pass
