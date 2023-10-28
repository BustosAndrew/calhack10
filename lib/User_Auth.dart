import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      // 1. Register the user with Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // 2. Create a document for the user in Firestore
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'height': null,
          'weight': null,
          'goalWeight': null,
          'allergies': null,
          'healthIssues': null,
        });
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('dailyValues')
            .add({
          'calories': null,
          'protein': null,
          'sugar': null,
          'sodium': null,
          'fat': null,
          'vitamins': null,
        });
      }

      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
