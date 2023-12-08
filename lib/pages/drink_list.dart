import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '/models/api.dart';
import '/models/drinks.dart';

class DrinkList extends StatefulWidget {
  const DrinkList({super.key});

  @override
  State<DrinkList> createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList> {
  final List<String> ingredients = [
    'Dry_Vermouth',
    'Gin',
    'Vodka',
    'Tequila',
    'White_Rum'
  ];
  List<String> selectedIngredients = [];
  late Future<Drinks> drinkList;

  @override
  void initState() {
    super.initState();
    ingredients.sort();
    drinkList = fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MultiSelectDropDown(
              onOptionSelected: (value) {
                setState(() {
                  selectedIngredients =
                      value.map((e) => e.value.toString()).toList();
                  drinkList = selectedIngredients.isEmpty
                      ? fetchAll()
                      : fetchByMultipleIngredients(selectedIngredients);
                });
              },
              options: ingredients
                  .map((e) =>
                      ValueItem(label: e.split('_').join(' '), value: e))
                  .toList(),
              selectionType: SelectionType.multi,
              chipConfig: const ChipConfig(wrapType: WrapType.wrap),
              selectedOptionIcon: const Icon(Icons.check),
              dropdownBorderRadius: 10.0,
              showClearIcon: true,
              dropdownMargin: 5.0,
            ),
          ),
        ),
        
        Expanded(
          child: FutureBuilder(
            future: drinkList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.drinks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListTile(
                                key: Key(snapshot.data!.drinks[index].id),
                                title: Text(snapshot.data!.drinks[index].drink),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    '${snapshot.data!.drinks[index].drinkThumb}/preview',
                                    cacheHeight: 100,
                                    cacheWidth: 100,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                              ),
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
        ),
      ],
    );
  }
}
