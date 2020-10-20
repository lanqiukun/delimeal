import 'package:delimeal/widgets/meal_item.dart';
import 'package:flutter/material.dart';

import '../widgets/category_item.dart';
import '../dummy_date.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  // final categoryId;
  // final categoryTitle;

  // CategoryMealsScreen(this.categoryId, this.categoryTitle);

  final List<Meal> _availableMeals;

  final Function _removeMeal;
  CategoryMealsScreen(this._removeMeal, this._availableMeals);

  static const routeName = '/category-meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;

  // void _removeMeal(String mealId) {
  //   setState(() {
  //     displayedMeals.removeWhere((element) => element.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print('category meal screen build()');

    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    final categoryId = routeArgs['id'];
    categoryTitle = routeArgs['title'];

    displayedMeals = widget._availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final category = displayedMeals[index];
          return MealItem(
            id: category.id,
            title: category.title,
            imageUrl: category.imageUrl,
            duration: category.duration,
            affordability: category.affordability,
            complexity: category.complexity,
            removeItem: widget._removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
