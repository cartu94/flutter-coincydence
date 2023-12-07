import 'package:cocktail_book/models/drink_details.dart';

class Drink {
  final String id;
  final String drink;
  final String drinkThumb;
  final DrinkDetails? drinkDetails;

  const Drink({
    required this.id,
    required this.drink,
    required this.drinkThumb,
    this.drinkDetails,
  });

  @override
  String toString() {
    return 'id: $id, drink: $drink, drinkThumb: $drinkThumb, drinkDetails: $drinkDetails';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Drink &&
        other.id == id &&
        other.drink == drink &&
        other.drinkThumb == drinkThumb;
  }

  @override
  int get hashCode => id.hashCode ^ drink.hashCode ^ drinkThumb.hashCode;
}
