import 'package:flutter/material.dart';

class MealPage extends StatefulWidget {
  @override
  _MealPageState createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Today's Meals")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildMealCard(
              "Breakfast",
              "Oatmeal",
              150,
              4,
              1,
              5,
              2,
              "Healthy oatmeal with fruits...",
              "1. Boil water...\n2. Add oats...",
              "Oats, Banana, Milk...",
            ),
            SizedBox(height: 16),
            buildMealCard(
              "Lunch",
              "Chicken Salad",
              350,
              20,
              5,
              10,
              15,
              "Fresh salad with grilled chicken...",
              "1. Grill chicken...\n2. Mix vegetables...",
              "Chicken, Lettuce, Tomato...",
            ),
            SizedBox(height: 16),
            buildMealCard(
              "Dinner",
              "Spaghetti",
              400,
              15,
              10,
              25,
              10,
              "Delicious spaghetti with marinara sauce...",
              "1. Boil spaghetti...\n2. Heat sauce...",
              "Spaghetti, Marinara sauce, Meat...",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMealCard(
    String mealType,
    String mealName,
    int calories,
    int protein,
    int sugar,
    int sodium,
    int fat,
    String description,
    String cookingInstructions,
    String shoppingList,
  ) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$mealType: $mealName",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
            SizedBox(height: 8),
            Text("Calories: $calories"),
            Text("Protein: $protein g"),
            Text("Sugar: $sugar g"),
            Text("Sodium: $sodium mg"),
            Text("Fat: $fat g"),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize
                            .min, // Set to adjust the content's size
                        children: [
                          Text("$mealName",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 12),
                          Text(description),
                          SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Cooking Instructions"),
                                    content: Text("$cookingInstructions"),
                                    actions: [
                                      ElevatedButton(
                                        child: Text("Close"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text("How to Cook"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Shopping List"),
                                    content: Text("$shoppingList"),
                                    actions: [
                                      ElevatedButton(
                                        child: Text("Close"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text("Shopping List"),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text("View More"),
            )
          ],
        ),
      ),
    );
  }
}
