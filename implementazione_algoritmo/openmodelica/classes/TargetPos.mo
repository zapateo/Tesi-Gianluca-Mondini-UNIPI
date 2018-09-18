/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function TargetPos
    input   Real  [2]    self_position;
    input   Real  [:,2]  other_drones_positions;
    input   Real  [:,4]  area_boundaries;
    output  Real  [2]    target_position;
algorithm
    target_position := CenterOfMass(
        EdgesToVertices(
            VoronoiCell(
                area_boundaries
            )
        )
    );
end TargetPos;
