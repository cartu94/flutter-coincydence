import 'package:cocktail_book/pages/drink_complete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '/pages/drink_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Coincydence',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.light,
            seedColor: const Color.fromRGBO(57, 21, 20, 1)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('COCKTAIL BOOK',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 30)),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: const DrinkListPage(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DrinkCompletePage(id: 'random')),
            );
          },
          child: Text('RANDOM DRINK',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 20)),
        )]);
  }
}
