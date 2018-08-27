# Implementazione algoritmo di Lloyd - Voronoi in Python

## Output grafico dell'algoritmo

(i frame con i bordi assenti sono determinati da problemi durante la registrazione)

![running.gif](running.gif)

## Procedimento (da aggiornare)

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
