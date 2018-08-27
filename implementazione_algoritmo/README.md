# Implementazione algoritmo

### Ingressi

Nome|Descrizione
--|--
Coordinate degli altri droni | vettore di coppie contenenti le coordinate _(x, y)_ di ognuno dei droni (ad eccezione di se stesso) sul piano bidimensionale

### Parametri

Nome|Descrizione
--|--
vertici dell'area | vettore di coppie contenenti le coordinate _(x, y)_ di ognugno dei vertici dell'area. Si suppone che l'area sia una figura geometrica bidimensionale convessa

### Uscite

Nome|Descrizione
--|--
coordinate del punto da raggiungere | vettore _(x,y)_ da comunicare al _Controllo di volo_

### Algoritmo (da verificare)

1. Riceve in ingresso le coordinate degli altri droni
2. Riceve in ingresso le proprie coordinate comunicate dal _Controllo di volo_
3. Viene eseguita la _Tassellazione di Voroni_ dell'area
4. Si considera la partizione a cui appartiene il drone stesso e se ne calcola il centro di massa
5. Viene comunicato il centro di massa come coordinata da raggiungere al _Controllo di volo_
