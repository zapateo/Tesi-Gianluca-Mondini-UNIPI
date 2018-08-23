# Implementazione algoritmo di Voronoi in Python
## Versione ottimizzata

A differenza della versione "completa" dell'algoritmo di Voronoi, questa restituisce soltanto la cella a cui appartiene il sito passato come argomento

### Input

- lista di segmenti rappresentanti il perimetro dell'area
- punto rappresentate il sito primario, ovvero la posizione del sito che effettua la computazione
- lista di punti rappresentanti i vari _siti_ (= droni), ad eccezione del sito primario

### Output

- lista di segmenti rappresentanti la cella di Voronoi del sito primario

### Algoritmo

Inizializzazione

- `edges` = perimetro dell'area
- `primary_site` = sito primario
- `other_sites` = lista degli altri siti

Procedimento

```
1} per ogni `site` in `other_sites`:
      2} genero il segmento `union_edge` che unisce `primary_site` e `site`
      3} trovo la retta bisettrice del segmento `union_edge` e la chiamo `perp_bisect`
      4} creo un lista di punti vuota `intersections`
      5} per ogni `edge` in `edges`:
            6} cerco i punti di intersezione tra la retta `perp_bisect` ed il segmento `edge` chiamandolo `intersect`
            7} se esiste `intersect`:
                  8} contrassegno `edge` per la cancellazione che avverrà in seguito
                  9} tra i due estremi di `edge`, prendo quello il cui segmento di unione con `primary_site` non interseca `perp_bisect` e lo chiamo `keep`
                  10} aggiungo ad `edges` un nuovo segmento con estremi (`intersect`, `keep`)
      11} aggiungo ad `edges` un nuovo segmento che ha come estremi i due punti contenuti in `intersections`; se il numero di punti è diverso da 2 sollevo un'eccezione
      12} elimino da `edges` tutti i segmenti contrassegnati per l'eliminazione
      13} per ogni segmento `edge` in `edges`:
            14} per ogni punto `p` in `edge`:
                  15} creo un segmento `join_edge` che unisce `primary_site` a `p`
                  16} cerco il punto di intersezione tra il segmento `join_edge` e `perp_bisect`
                  17} se il punto di intersezione non esiste, vado avanti senza fare nulla
                  18} se il punto di intersezione esiste ed è diverso da `p`, allora contrassegno `edge` per l'eliminazione
      19} elimino da `edges` tutti i segmenti contrassegnati per l'eliminazione
```
