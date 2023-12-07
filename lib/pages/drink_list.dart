import 'package:flutter/material.dart';

import '/models/api.dart';

class DrinkList extends StatefulWidget {
  const DrinkList({super.key});

  @override
  State<DrinkList> createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: FutureBuilder(
            future: fetchByMultipleIngredients(['Dry_Vermouth']),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.drinks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              key: Key(snapshot.data!.drinks[index].id),
                              title: Text(snapshot.data!.drinks[index].drink),
                              leading: Image.network(
                                  '${snapshot.data!.drinks[index].drinkThumb}/preview'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        )
      ],
    );
  }
}
