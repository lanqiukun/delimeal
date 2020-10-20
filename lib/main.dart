import 'package:flutter/material.dart';

import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/filters_screen.dart';
import 'dummy_date.dart';

import 'models/meal.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = [];
  List<Meal> _favoritesMeals = [];

  @override
  void initState() {
    print('init state');
    for (var item in DUMMY_MEALS) _availableMeals.add(item);

    // TODO: implement initState
    super.initState();
  }

  void _removeMeal(String mealId) {
    setState(() {
      print(_availableMeals.length);
      _availableMeals.removeWhere((element) => element.id == mealId);
      print(_availableMeals.length);
    });
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = _availableMeals.where((element) {
        if (_filters['gluten'] && !element.isGlutenFree) return false;
        if (_filters['lactose'] && !element.isLactoseFree) return false;
        if (_filters['vegan'] && !element.isVegan) return false;
        if (_filters['vegetarian'] && !element.isVegetarian) return false;

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    print(mealId);
    final existIndex =
        _favoritesMeals.indexWhere((element) => element.id == mealId);
    if (existIndex >= 0)
      setState(() {
        _favoritesMeals.removeAt(existIndex);
      });
    else
      setState(() {
        _favoritesMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
  }

  bool _isFavorite(String mealId) {
    return _favoritesMeals.indexWhere((element) => element.id == mealId) >= 0;
  }

  @override
  Widget build(BuildContext context) {
    print('build method');

    print(_availableMeals.length);
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      title: 'DeliMeal',
      // home: CategoriesScreen(),
      initialRoute: '/', //default is '/'
      routes: {
        '/': (context) => TabsScreen(_favoritesMeals, _removeMeal),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_removeMeal, _availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavorite, _isFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        print(settings.name);
        return MaterialPageRoute(
          builder: (context) {
            CategoriesScreen();
          },
        );
      },
      onUnknownRoute: (context) {
        return MaterialPageRoute(
          builder: (context) => CategoriesScreen(),
        );
      },
    );
  }
}
