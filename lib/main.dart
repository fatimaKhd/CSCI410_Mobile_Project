import 'package:flutter/material.dart';
import 'recipe_details_screen.dart';
import 'splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sweet Recipes',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _ingredientController = TextEditingController();
  final List<String> categories = ['All', 'Cakes', 'Pastries', 'Puddings'];
  String selectedCategory = 'All';

  final Map<String, Map<String, dynamic>> recipes = {
    'Chocolate Cake': {
      'category': 'Cakes',
      'image': 'assets/images/chocolate_cake.jpg',
      'ingredients': 'Flour, Cocoa Powder, Eggs, Sugar, Butter',
      'steps': ['Mix dry ingredients.', 'Add wet ingredients.', 'Bake at 180°C for 30 minutes.']
    },
    'Pancakes': {
      'category': 'Pastries',
      'image': 'assets/images/pancakes.jpg',
      'ingredients': 'Flour, Milk, Eggs, Sugar, Butter',
      'steps': ['Mix ingredients into a batter.', 'Pour onto a pan.', 'Flip and cook both sides.']
    },
    'Strawberry Cheesecake': {
      'category': 'Cakes',
      'image': 'assets/images/strawberry_cheesecake.jpg',
      'ingredients': 'Cream Cheese, Strawberries, Sugar, Biscuit Crust',
      'steps': ['Prepare crust.', 'Mix cream cheese and sugar.', 'Add strawberry topping and refrigerate.']
    },
    'Chocolate Mousse': {
      'category': 'Puddings',
      'image': 'assets/images/chocolate_mousse.jpg',
      'ingredients': 'Chocolate, Cream, Sugar, Eggs',
      'steps': ['Melt chocolate.', 'Whisk cream.', 'Chill for 2 hours.']
    },
  };

  List<String> filteredRecipes = [];
  final Set<String> favorites = {};

  void searchRecipes(String input) {
    setState(() {
      filteredRecipes = recipes.keys.where((recipe) {
        final isCategoryMatch = selectedCategory == 'All' || recipes[recipe]!['category'] == selectedCategory;
        final isIngredientMatch = recipes[recipe]!['ingredients'].toLowerCase().contains(input.toLowerCase());
        return isCategoryMatch && isIngredientMatch;
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    filteredRecipes = recipes.keys.toList(); // Show all recipes initially
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sweet Recipes'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailsScreen(
                    recipeName: 'Favorites',
                    favorites: favorites.toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                  searchRecipes(_ingredientController.text);
                });
              },
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _ingredientController,
              decoration: InputDecoration(
                labelText: 'Search by ingredient...',
                border: OutlineInputBorder(),
              ),
              onChanged: searchRecipes,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = filteredRecipes[index];
                  return Card(
                    child: ListTile(
                      leading: Image.asset(
                        recipes[recipe]!['image'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(recipe),
                      subtitle: Text(recipes[recipe]!['category']),
                      trailing: IconButton(
                        icon: Icon(
                          favorites.contains(recipe) ? Icons.favorite : Icons.favorite_border,
                          color: favorites.contains(recipe) ? Colors.red : null,
                        ),
                        onPressed: () {
                          setState(() {
                            if (favorites.contains(recipe)) {
                              favorites.remove(recipe);
                            } else {
                              favorites.add(recipe);
                            }
                          });
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailsScreen(
                              recipeName: recipe,
                              recipeDetails: recipes[recipe]!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
