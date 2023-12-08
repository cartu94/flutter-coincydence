import 'package:flutter/material.dart';

import '/models/api.dart';

class DrinkCompletePage extends StatelessWidget {
  final String id;
  final String name;

  const DrinkCompletePage({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: FutureBuilder(
        future: fetchByID(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}\nPlease try again'));
          } else {
            final drinkDetails = snapshot.data!;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(drinkDetails.drinks[0].drinkThumb),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Ingredients'),
                        ...snapshot.data!.drinks[0].drinkDetails!.ingredients
                            .map((ingredient) => Text(ingredient))
                            .toList(),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Measures'),
                        ...snapshot.data!.drinks[0].drinkDetails!.measures
                            .map((measure) => Text(measure))
                            .toList(),
                      ],
                    ),
                  ],
                ),
                const Text("Instructions"),
                Text(snapshot.data!.drinks[0].drinkDetails!.instructions),
              ],
            );
          }
        },
      ),
    );
  }
}
