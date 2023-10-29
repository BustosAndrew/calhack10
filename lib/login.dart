import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zeppos/User_Auth.dart';
import 'package:zeppos/homepage.dart';
import 'package:zeppos/signUp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Login Page')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading =
                        true; // Assuming you have a boolean _isLoading initialized to false in your state.
                  });
                  dynamic result = await _auth.signInWithEmailAndPassword(
                      _emailController.text, _passwordController.text);
                  setState(() {
                    _isLoading = false;
                  });
                  if (result == null) {
                    print('Error signing in');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Error signing in. Please check your credentials.')), // You can replace this generic message with a specific error message if needed.
                    );
                  } else {
                    print('Signed in');
                    print(result.uid);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                },
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        'Sign In'), // Show a loading indicator when _isLoading is true.
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  child: const Text('SignUp'))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
