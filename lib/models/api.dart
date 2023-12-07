import 'dart:convert';

import 'package:http/http.dart' as http;

import 'drinks.dart';
import 'drink.dart';

/// Fetches a list of drinks from https://www.thecocktaildb.com/api.php

/// Fetches a list of alcoholic drinks from the API
Future<Drinks> fetchAlcoholic() async {
  final response = await http.get(Uri.parse(
      'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'));

  if (response.statusCode == 200) {
    return Drinks.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load alcoholic drinks');
  }
}

/// Fetches a list of non-alcoholic drinks from the API
Future<Drinks> fetchNonAlcoholic() async {
  final response = await http.get(Uri.parse(
      'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic'));

  if (response.statusCode == 200) {
    return Drinks.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load non-alcoholic drinks');
  }
}

/// Fetches a list of drinks both alcoholic and non-alcoholic from the API
/// This is the default list of drinks that is displayed when the app is opened
Future<Drinks> fetchAll() async {
  final alcoholic = await fetchAlcoholic();
  final nonAlcoholic = await fetchNonAlcoholic();
  Drinks allDrinks =
      Drinks(drinks: [...alcoholic.drinks, ...nonAlcoholic.drinks]);
  allDrinks.drinks.sort((a, b) => a.drink.compareTo(b.drink));
  return allDrinks;
}

/// Fetches a drinks by his ID from the API
Future<Drinks> fetchByID(String id) async {
  final response = await http.get(Uri.parse(
      'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id'));

  if (response.statusCode == 200) {
    return Drinks.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load drinks by id');
  }
}

/// Fetches a list of drinks by an ingredient from the API
Future<Drinks> fetchByIngredient(String ingredient) async {
  final response = await http.get(Uri.parse(
      'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=$ingredient'));

  if (response.statusCode == 200) {
    return Drinks.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load drinks by ingredient');
  }
}

/// Fetches a random drink from the API
Future<Drinks> fetchRandom() async {
  final response = await http
      .get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/random.php'));

  if (response.statusCode == 200) {
    return Drinks.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load random drink');
  }
}

/// Fetches a list of drinks by multiple ingredients from the API
/// The ingredients are passed as a list of strings
Future<Drinks> fetchByMultipleIngredients(List<String> ingredients) async {
  try {
    List<Future<Drinks>> futures = ingredients.map(fetchByIngredient).toList();
    List<Drinks> results = await Future.wait(futures);
        List<Drink> intersection = results
        .fold<Set<Drink>>(results.first.drinks.toSet(),
            (a, b) => a.intersection(b.drinks.toSet()))
        .toList();
    return Drinks(drinks: intersection);
  } catch (e) {
    throw Exception('Failed to load drinks by multiple ingredients');
  }
}
