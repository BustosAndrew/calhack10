import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FoodEntryPage extends StatefulWidget {
  @override
  _FoodEntryPageState createState() => _FoodEntryPageState();
}

class _FoodEntryPageState extends State<FoodEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? name;
  int? calories;
  int? protein;
  int? fat;
  int? sugar;
  int? sodium;
  List<String> ingredients = [];
  List<String> allergens = [];
  List<String> vitamins = [];
  String? recipe;
  bool isMeal = false; // New variable to track if food is a meal
  Map<String, String> mealIngredients =
      {}; // New variable to store ingredients and their quantities for a meal

  TextEditingController ingredientAmountController =
      TextEditingController(); // For the quantity of the meal ingredient

  List<String> cookingInstructions =
      []; // List to store step-by-step cooking instructions
  TextEditingController cookingInstructionController =
      TextEditingController(); // For entering each cooking step

  TextEditingController ingredientController = TextEditingController();
  TextEditingController allergenController = TextEditingController();
  TextEditingController vitaminController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Food Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Food Name
              TextFormField(
                onChanged: (value) => name = value,
                decoration: InputDecoration(labelText: 'Food Name'),
                validator: (value) => value!.isEmpty ? 'Enter Food Name' : null,
              ),
              // Calories
              TextFormField(
                onChanged: (value) => calories = int.tryParse(value),
                decoration: InputDecoration(labelText: 'Calories'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter Calories' : null,
              ),
              // Protein
              TextFormField(
                onChanged: (value) => protein = int.tryParse(value),
                decoration: InputDecoration(labelText: 'Protein (g)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter Protein amount' : null,
              ),
              // Fat
              TextFormField(
                onChanged: (value) => fat = int.tryParse(value),
                decoration: InputDecoration(labelText: 'Fat (g)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter Fat amount' : null,
              ),
              // Sugar
              TextFormField(
                onChanged: (value) => sugar = int.tryParse(value),
                decoration: InputDecoration(labelText: 'Sugar (g)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter Sugar amount' : null,
              ),
              // Sodium
              TextFormField(
                onChanged: (value) => sodium = int.tryParse(value),
                decoration: InputDecoration(labelText: 'Sodium (mg)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter Sodium amount' : null,
              ),
              // Dynamic ingredients list
              ...ingredients.map((ingredient) => Text(ingredient)),
              TextFormField(
                controller: ingredientController,
                decoration: InputDecoration(labelText: 'Add Ingredient'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (ingredientController.text.isNotEmpty) {
                    setState(() {
                      ingredients.add(ingredientController.text);
                      ingredientController.clear();
                    });
                  }
                },
                child: Text('Add Ingredient'),
              ),
              // Dynamic allergens list
              ...allergens.map((allergen) => Text(allergen)),
              TextFormField(
                controller: allergenController,
                decoration: InputDecoration(labelText: 'Add Allergen'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (allergenController.text.isNotEmpty) {
                    setState(() {
                      allergens.add(allergenController.text);
                      allergenController.clear();
                    });
                  }
                },
                child: Text('Add Allergen'),
              ),
              // Dynamic vitamins list
              ...vitamins.map((vitamin) => Text(vitamin)),
              TextFormField(
                controller: vitaminController,
                decoration: InputDecoration(labelText: 'Add Vitamin'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (vitaminController.text.isNotEmpty) {
                    setState(() {
                      vitamins.add(vitaminController.text);
                      vitaminController.clear();
                    });
                  }
                },
                child: Text('Add Vitamin'),
              ),
              // Recipe
              TextFormField(
                onChanged: (value) => recipe = value,
                decoration: InputDecoration(labelText: 'Recipe'),
                maxLines: 5,
                validator: (value) => value!.isEmpty ? 'Enter Recipe' : null,
              ),
              Row(
                children: [
                  Text("Is it a meal?"),
                  Checkbox(
                    value: isMeal,
                    onChanged: (bool? value) {
                      setState(() {
                        isMeal = value!;
                      });
                    },
                  ),
                ],
              ),

              if (isMeal) ...[
                // Dynamic list for meal ingredients and their quantities
                ...mealIngredients.entries
                    .map((e) => Text('${e.key}: ${e.value}')),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: ingredientController,
                        decoration: InputDecoration(
                            labelText: 'Ingredient (e.g., onions)'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: ingredientAmountController,
                        decoration: InputDecoration(
                            labelText: 'Amount (e.g., 1 whole)'),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (ingredientController.text.isNotEmpty &&
                        ingredientAmountController.text.isNotEmpty) {
                      setState(() {
                        mealIngredients[ingredientController.text] =
                            ingredientAmountController.text;
                        ingredientController.clear();
                        ingredientAmountController.clear();
                      });
                    }
                  },
                  child: Text('Add Ingredient for Meal'),
                ),

                // Dynamic list for step-by-step cooking instructions
                ...cookingInstructions.map((instruction) => Text(instruction)),
                TextFormField(
                  controller: cookingInstructionController,
                  decoration: InputDecoration(labelText: 'Add Cooking Step'),
                  maxLines: 3,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (cookingInstructionController.text.isNotEmpty) {
                      setState(() {
                        cookingInstructions
                            .add(cookingInstructionController.text);
                        cookingInstructionController.clear();
                      });
                    }
                  },
                  child: Text('Add Cooking Step'),
                ),
              ],

              SizedBox(height: 20),
              // Submit Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _firestore.collection('foods').add({
                      'name': name,
                      'calories': calories,
                      'protein': protein,
                      'fat': fat,
                      'sugar': sugar,
                      'sodium': sodium,
                      'ingredients': ingredients,
                      'allergens': allergens,
                      'vitamins': vitamins,
                      'recipe': recipe,
                      'isMeal': isMeal,
                    });
                    // Clear form and show a success message
                    ingredientController.clear();
                    allergenController.clear();
                    vitaminController.clear();
                    ingredients.clear();
                    allergens.clear();
                    vitamins.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Food added successfully!')),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
