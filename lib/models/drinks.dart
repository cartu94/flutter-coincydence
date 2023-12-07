import 'drink.dart';
import 'drink_details.dart';

class Drinks {
  final List<Drink> drinks;

  const Drinks({required this.drinks});

  factory Drinks.fromJson(Map<String, dynamic> json) {
    List<dynamic> values = json["drinks"];
    List<String> ingredients = [];
    List<String> measures = [];
    List<Drink> drinks = values.map((value) {
      if (value is Map<String, dynamic>) {
        value.forEach((key, value) {
        if (key.contains('strIngredient') && value != null) {
          ingredients.add(value);
        }
        if (key.contains('strMeasure') && value != null) {
          measures.add(value);
        }
      });
    }
      return Drink(
        id: value['idDrink'] as String,
        drink: value['strDrink'] as String,
        drinkThumb: value['strDrinkThumb'] as String,
        drinkDetails: value['strInstructions'] != null ? DrinkDetails(
          instructions: value['strInstructions'] as String,
          category: value['strCategory'] as String,
          alcoholic: value['strAlcoholic'] as String,
          glass: value['strGlass'] as String,
          ingredients: ingredients,
          measures: measures,
        ) : null,
      );
    }).toList();

    return Drinks(drinks: drinks);
  }

  @override
  String toString() {
    return drinks.toString();
  }
}
