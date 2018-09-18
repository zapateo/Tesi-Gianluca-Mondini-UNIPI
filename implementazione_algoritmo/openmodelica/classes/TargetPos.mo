/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function TargetPos

    // La posizione del drone stesso, es: {54.432, -432.6662}
    input   Real  [2]    self_position;

    // La lista delle posizioni degli altri droni,
    // es: {{43.11, 0.43}, {432.233, -123.01}}
    input   Real  [:,2]  other_drones_positions;

    // La lista dei "bordi" dell'area
    // ovvero una lista di liste di 4 elementi
    // es: {{0,0,1,0}, {1,0,1,1}, {1,1,0,0}}
    input   Real  [:,4]  area_boundaries;

    // La posizione da raggiungere, nel formato {x, y}
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
