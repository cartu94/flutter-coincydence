import 'package:cocktail_book/models/drink.dart';
import 'package:flutter/material.dart';

import '/models/api.dart';

class DrinkCompletePage extends StatelessWidget {
  final String id;

  const DrinkCompletePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: id != 'random' ? fetchByID(id) : fetchRandom(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("ERROR"),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              body: Center(child: Text('${snapshot.error}\nPlease try again')));
        } else {
          final drinkSnapshot = snapshot.data!.drinks[0];
          return Scaffold(
              appBar: AppBar(
                title: Text(drinkSnapshot.drink.toUpperCase(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSecondary)),
                centerTitle: true,
                iconTheme: IconThemeData(
                    color: Theme.of(context).colorScheme.onSecondary),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (MediaQuery.of(context).orientation ==
                          Orientation.portrait) ...[
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              image(drinkSnapshot),

                              const SizedBox(
                                width: 20.0,
                              ), // gap

                              Expanded(
                                child: extraColumn(drinkSnapshot),
                              )
                            ]),

                        const SizedBox(
                          height: 30.0,
                        ), // gap

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ingredients(drinkSnapshot),
                            measures(drinkSnapshot),
                          ],
                        ),
                      ] else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            image(drinkSnapshot),
                            extraColumn(drinkSnapshot),
                            ingredients(drinkSnapshot),
                            measures(drinkSnapshot),
                          ],
                        ),

                      SizedBox(
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 30.0
                            : 10.0,
                      ), // gap

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: id == 'random' ? 10.0 : 0),
                              child: instructions(drinkSnapshot),
                            ),
                          ),
                          if (id == 'random') refreshRandomFAB(context),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        }
      },
    );
  }

  Widget refreshRandomFAB(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child:
          Icon(Icons.refresh, color: Theme.of(context).colorScheme.onSecondary),
      onPressed: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const DrinkCompletePage(
              id: 'random',
            ),
          ),
        );
      },
    );
  }

  Widget instructions(Drink drinkSnapshot) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Align(
        alignment: Alignment.center,
        child: Text(
          "Instructions",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      SingleChildScrollView(
        child: Text(drinkSnapshot.drinkDetails!.instructions
            .split('. ')
            .map((element) {
              return '· $element';
            })
            .toList()
            .join('.\n')),
      )
    ]);
  }

  Widget measures(Drink drinkSnapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Measures',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ...drinkSnapshot.drinkDetails!.measures
            .map((measure) => Text(measure))
            .toList(),
      ],
    );
  }

  Widget ingredients(Drink drinkSnapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'Ingredients',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ...drinkSnapshot.drinkDetails!.ingredients
            .map((ingredient) => Text(ingredient))
            .toList(),
      ],
    );
  }

  Widget extraColumn(Drink drinkSnapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Category:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(drinkSnapshot.drinkDetails!.category),
        ),
        const SizedBox(
          height: 10.0,
        ), // gap
        const Text(
          "Alcoholic:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(drinkSnapshot.drinkDetails!.alcoholic),
        ),
        const SizedBox(
          height: 10.0,
        ), // gap
        const Text(
          "Glass:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(drinkSnapshot.drinkDetails!.glass),
        ),
      ],
    );
  }

  Widget image(Drink drinkSnapshot) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network('${drinkSnapshot.drinkThumb}/preview'),
    );
  }
}
