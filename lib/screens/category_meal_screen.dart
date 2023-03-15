import 'package:flutter/material.dart';

import '/Widgets/meal_item.dart';
import '/models/meal.dart';

import '../dummy_data.dart';

class CategoryMealScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  // final String categoryId;
  // final String categoryTitle;

  // CategoryMealScreen(this.categoryId, this.categoryTitle);

  List<Meal> filteredMeals;

  CategoryMealScreen(this.filteredMeals);

  @override
  Widget build(BuildContext context) {
    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryTitle = routeArg['title'];
    final categoryId = routeArg['id'];

    final categoryMeal = filteredMeals.where(
      (meal) {
        return meal.categories.contains(categoryId);
      },
    ).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: categoryMeal.isNotEmpty
          ? ListView.builder(
              itemBuilder: ((ctx, index) {
                return MealItem(
                    id: categoryMeal[index].id,
                    title: categoryMeal[index].title,
                    imageUrl: categoryMeal[index].imageUrl,
                    duration: categoryMeal[index].duration,
                    complexity: categoryMeal[index].complexity,
                    affordability: categoryMeal[index].affordability);
              }),
              itemCount: categoryMeal.length,
            )
          : Column(
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: Icon(
                    Icons.error,
                    size: 35,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'There is no meals for selected filters in this category.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
    );
  }
}
