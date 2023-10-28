import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodEntryPage extends StatefulWidget {
  @override
  _FoodEntryPageState createState() => _FoodEntryPageState();
}

class _FoodEntryPageState extends State<FoodEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? name;
  String? calories;
  String? protein;
  String? fat;
  String? sugar;
  String? sodium;
  List<String> ingredients = [];
  List<String> allergens = [];
  List<String> vitamins = [];
  String? recipe;

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
                onChanged: (value) => calories = value,
                decoration: InputDecoration(labelText: 'Calories'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter Calories' : null,
              ),
              // Protein
              TextFormField(
                onChanged: (value) => protein = value,
                decoration: InputDecoration(labelText: 'Protein (g)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter Protein amount' : null,
              ),
              // Fat
              TextFormField(
                onChanged: (value) => fat = value,
                decoration: InputDecoration(labelText: 'Fat (g)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter Fat amount' : null,
              ),
              // Sugar
              TextFormField(
                onChanged: (value) => sugar = value,
                decoration: InputDecoration(labelText: 'Sugar (g)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter Sugar amount' : null,
              ),
              // Sodium
              TextFormField(
                onChanged: (value) => sodium = value,
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
