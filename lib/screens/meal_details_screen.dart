import 'package:flutter/material.dart';

import '/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-details';

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget _buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 5),
      child: Text(text, style: Theme.of(context).textTheme.headline6),
    );
  }

  Widget _buildContainer(BuildContext context, Widget child) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueGrey),
      ),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.70,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.30,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          _buildSectionTitle(context, 'Ingredients'),
          _buildContainer(
            context,
            Scrollbar(
              child: ListView.builder(
                itemBuilder: ((ctx, index) => Card(
                      elevation: 3,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(
                          selectedMeal.ingredients[index],
                          textAlign: TextAlign.center,
                        ),
                      ),
                      color: Theme.of(context).accentColor,
                    )),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
          ),
          _buildSectionTitle(context, 'Steps'),
          _buildContainer(
            context,
            ListView.builder(
              itemBuilder: ((ctx, index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('#${index + 1}'),
                        ),
                        title: Text(selectedMeal.steps[index]),
                      ),
                      Divider()
                    ],
                  )),
              itemCount: selectedMeal.steps.length,
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(mealId) == true ? Icons.star : Icons.star_border,
        ),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}
