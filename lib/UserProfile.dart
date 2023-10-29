import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zeppos/User_Auth.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final AuthService _auth = AuthService();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightFeetController = TextEditingController();
  final TextEditingController _heightInchesController = TextEditingController();
  final TextEditingController _goalWeightController = TextEditingController();
  final TextEditingController _allergyController = TextEditingController();
  final TextEditingController _healthIssueController = TextEditingController();

  List<String> allergies = [];
  List<String> healthIssues = [];
  // Add age controller for the BMR calculation
  final TextEditingController _ageController = TextEditingController();

  // This function returns the estimated TDEE
  double calculateTDEE(double weight, double heightInInches, int age) {
    double heightInCm = heightInInches * 2.54;
    double weightInKg = weight * 0.453592; // convert lbs to kg

    // Mifflin-St Jeor Equation for men as an example.
    // Adjust this for women or other genders as necessary
    double bmr = (10 * weightInKg) + (6.25 * heightInCm) - (5 * age) + 5;
    double tdee = bmr * 1.2; // Assuming sedentary activity level

    return tdee;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Add Age TextField somewhere appropriate in your form
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _heightFeetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (ft)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _heightInchesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (inches)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _goalWeightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Goal Weight',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _allergyController,
              decoration: InputDecoration(
                labelText: 'Add Allergy',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  allergies.add(_allergyController.text);
                  _allergyController.clear();
                });
              },
              child: Text('Add Allergy'),
            ),
            Wrap(
              spacing: 8,
              children: allergies
                  .map((allergy) => Chip(label: Text(allergy)))
                  .toList(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _healthIssueController,
              decoration: InputDecoration(
                labelText: 'Add Health Issue',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  healthIssues.add(_healthIssueController.text);
                  _healthIssueController.clear();
                });
              },
              child: Text('Add Health Issue'),
            ),
            Wrap(
              spacing: 8,
              children: healthIssues
                  .map((issue) => Chip(label: Text(issue)))
                  .toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                double heightInInches =
                    (double.tryParse(_heightFeetController.text) ?? 0) * 12 +
                        (double.tryParse(_heightInchesController.text) ?? 0);
                double weight = double.tryParse(_weightController.text) ?? 0;
                int age = int.tryParse(_ageController.text) ?? 0;

                double tdee = calculateTDEE(weight, heightInInches, age);
                double goalcals = tdee - 500;

                double goalprotein = goalcals * 0.15 / 4;
                double goalcarbs = goalcals * 0.55 / 4;
                double goalfat = goalcals * 0.30 / 9;
                double goalsugar = goalcals * 0.05 / 4;
                double goalsodium = 2300.0;

                // Rounding to nearest hundredth
                goalcals = (goalcals * 100).roundToDouble() / 100;
                goalprotein = (goalprotein * 100).roundToDouble() / 100;
                goalsugar = (goalsugar * 100).roundToDouble() / 100;
                goalfat = (goalfat * 100).roundToDouble() / 100;

                User? currentUser = _auth.currentUser;
                if (currentUser != null) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUser.uid)
                      .update({
                    'weight': weight,
                    'height': heightInInches,
                    'goalWeight': _goalWeightController.text,
                    'allergies': allergies,
                    'healthIssues': healthIssues,
                    'goalcals': goalcals,
                    'goalprotein': goalprotein,
                    'goalsugar': goalsugar,
                    'goalfat': goalfat,
                    'goalsodium': goalsodium,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile and goals updated!')),
                  );
                }
              },
              child: Text('Update Profile and Goals'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightFeetController.dispose();
    _heightInchesController.dispose();
    _goalWeightController.dispose();
    _allergyController.dispose();
    _healthIssueController.dispose();
    super.dispose();
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
}
