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
- per ogni `site` in `other_sites`:
      - genero il segmento `union_edge` che unisce `primary_site` e `site`
      - trovo la retta bisettrice del segmento `union_edge` e la chiamo `perp_bisect`
      - creo una lista di punti vuota `intersections`
      - creo una lista di segmenti vuota `new_edges`
      - per ogni `edge` in `edges`:
            - cerco i punti di intersezione tra la retta `perp_bisect` ed il segmento `edge` chiamandolo `intersect`
            - se esiste `intersect`:
                  - contrassegno `edge` per la cancellazione che avverrà in seguito
                  - tra i due estremi di `edge`, prendo quello il cui segmento di unione con `primary_site` non interseca `perp_bisect` e lo chiamo `keep`
                  - aggiungo a `new_edges` un nuovo segmento con estremi (`intersect`, `keep`)
                  - aggiungo `intersect` ad `intersections`
      - aggiungo a `edges` i segmenti contenuti in `new_edges`
      - aggiungo ad `edges` un nuovo segmento che ha come estremi i due punti contenuti in `intersections`; se il numero di punti è diverso da 2 sollevo un'eccezione
      - elimino da `edges` tutti i segmenti contrassegnati per l'eliminazione
- per ogni segmento `edge` in `edges`:
      - per ogni punto `p` in `edge`:
            - creo un segmento `join_edge` che unisce `primary_site` a `p`
            - cerco il punto di intersezione tra il segmento `join_edge` e `perp_bisect`
            - se il punto di intersezione non esiste, vado avanti senza fare nulla
            - se il punto di intersezione esiste ed è diverso da `p`, allora contrassegno `edge` per l'eliminazione
- elimino da `edges` tutti i segmenti contrassegnati per l'eliminazione
```
