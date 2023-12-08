import 'package:cocktail_book/pages/drink_complete.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '/models/api.dart';
import '/models/drinks.dart';

class DrinkListPage extends StatefulWidget {
  const DrinkListPage({super.key});

  @override
  State<DrinkListPage> createState() => _DrinkListPageState();
}

class _DrinkListPageState extends State<DrinkListPage> {
  final List<String> ingredients = [
    'Dry_Vermouth',
    'Gin',
    'Vodka',
    'Tequila',
    'White_Rum',
    'Triple_Sec',
    'Grenadine',
    'Sweet_and_sour',
    'Club_soda',
    'Cachaca',
    'Lemon_Juice',
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
          color: Theme.of(context).colorScheme.primary,
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
                  .map(
                      (e) => ValueItem(label: e.split('_').join(' '), value: e))
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
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    indent: 10,
                    endIndent: 10,
                  ),
                  itemCount: snapshot.data!.drinks.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(snapshot.data!.drinks[index].drink.toUpperCase(), style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
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
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DrinkCompletePage(
                                          id: snapshot.data!.drinks[index].id,
                                        )));
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
