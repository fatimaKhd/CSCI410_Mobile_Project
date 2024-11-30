import 'package:flutter/material.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final String recipeName; // For single recipe or favorites
  final List<String>? favorites; // List of favorite recipes
  final Map<String, dynamic>? recipeDetails; // Details for a single recipe

  RecipeDetailsScreen({
    required this.recipeName,
    this.favorites,
    this.recipeDetails,
  });

  @override
  Widget build(BuildContext context) {
    if (favorites != null) {
      // Display favorites list
      return Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
        ),
        body: ListView.builder(
          itemCount: favorites!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(favorites![index]),
              trailing: Icon(Icons.favorite, color: Colors.red),
            );
          },
        ),
      );
    }

    // Display single recipe details
    final Map<String, dynamic> recipe = recipeDetails!;
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(recipe['image']),
              SizedBox(height: 20),
              Text(
                'Ingredients:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(recipe['ingredients']),
              SizedBox(height: 20),
              Text(
                'Steps:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ...recipe['steps'].map<Widget>((step) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text('- $step'),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
