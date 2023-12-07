class DrinkDetails {
  final String instructions;
  final String category;
  final String alcoholic;
  final String glass;
  final List<String> ingredients;
  final List<String> measures;

  const DrinkDetails({
    required this.instructions,
    required this.category,
    required this.alcoholic,
    required this.glass,
    required this.ingredients,
    required this.measures,
  });

  @override
  String toString() {
    return 'instructions: $instructions, category: $category, alcoholic: $alcoholic, glass: $glass, ingredients: $ingredients, measures: $measures';
  }
}