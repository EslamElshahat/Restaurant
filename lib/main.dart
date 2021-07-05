import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:meal/dummy_data.dart';
import 'package:meal/screens/category_meal_screen.dart';
import 'package:meal/screens/filters_screen.dart';
import 'package:meal/screens/meal_detail_screen.dart';
import 'package:meal/screens/tabs_screen.dart';

import 'modules/meal.dart';
// import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];


  void _toggleFavorite(String mealId){
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0 ){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }

  }

  Void? _setFilters(Map<String, bool> _filtersData) {
    setState(() {
      _filters = _filtersData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegan']!&& !meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isGlutenFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                body1: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                body2: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              )),
      // home: MyHomePage(),
      routes: {
        '/': (context) => TabsScreen(_favoriteMeals),
        CategoryMealScreen.routeName: (context) =>
            CategoryMealScreen(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routeName: (context) => FiltersScreen(_filters,_setFilters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal App"),
      ),
      body: null,
    );
  }
}
