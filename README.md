# Cocktail Book

Un semplice progetto Flutter che utilizza <https://www.thecocktaildb.com/api.php> come API in versione free (non completa).

Il progetto è stato testato su Andorid 8, 11 e 14

È stato realizzato utilizzando Flutter 3.16.2

## Getting Started

**Step 1:**

Scarica o clona la repo utilizzando il seguente link:

```plain
https://github.com/cartu94/flutter-coincydence.git
```

**Step 2:**

Posizionati nella cartella del progetto ed esegui il seguente comando nella console per ottenere le dipendenze richieste:

```bash
flutter pub get
```

**Step 3:**

Testa l'applicazione per mezzo del comando:

```bash
flutter run
```

## How to use

Il progetto consiste in un libro di ricette di cocktail (alcolici e non).

È possibile selezionare un cocktail dalla lista per vederne i dettagli.

Si può filtrare la ricerca per mezzo di ingredienti anche multipli (l'API non è realizzata benissimo quindi non c'è a disposizione una lista di tutti gli ingredienti ma solo di alcuni inseriti a mano).\
La funzione per filtrare selezionando più di un ingrediente ha necessitato un implementazione poiché era presente solo nel piano premium.

È possibile visualizzare un cocktail random premendo il pulsante nella pagina principale.\
La pagina con i dettagli presenta un pulsante di refresh se raggiunta tramite cocktail random.
