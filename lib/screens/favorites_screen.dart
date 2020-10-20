import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favoritesMeals;
  final Function _removeMeal;
  FavoritesScreen(this._favoritesMeals, this._removeMeal);

  @override
  Widget build(BuildContext context) {
    print('favorite screen');
    if (_favoritesMeals.isEmpty)
      return Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    else
      return ListView.builder(
        itemBuilder: (context, index) {
          final category = _favoritesMeals[index];
          return MealItem(
            id: category.id,
            title: category.title,
            imageUrl: category.imageUrl,
            duration: category.duration,
            affordability: category.affordability,
            complexity: category.complexity,
            removeItem: _removeMeal,
          );
        },
        itemCount: _favoritesMeals.length,
      );
  }
}
