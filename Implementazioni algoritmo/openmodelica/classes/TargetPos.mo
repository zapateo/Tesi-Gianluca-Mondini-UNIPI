/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

function TargetPos

    input   Real  [:,4]  area_boundaries;
    input   Real  [2]    self_position;
    input   Real  [:,2]  other_drones_positions;
    output  Real  [2]    target_position;

algorithm
    target_position := CenterOfMass(
        EdgesToVertices(
            VoronoiCell(
                area_boundaries,
                self_position,
                other_drones_positions
            )
        )
    );
end TargetPos;
