import 'package:flutter/material.dart';

class NutritionalFactCard extends StatelessWidget {
  const NutritionalFactCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Grilled Chicken Salad', // Meal name
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Nutritional Facts:'),
            SizedBox(height: 10),
            Text('Calories: 250 kcal'), // dummy data
            Text('Protein: 30g'), // dummy data
            Text('Carbohydrates: 20g'), // dummy data
            Text('Fat: 10g'), // dummy data
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle "view more" logic here
                print('View More button pressed');
              },
              child: Text('View More'),
            ),
          ],
        ),
      ),
    );
  }
}
