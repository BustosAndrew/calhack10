import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Column(
          children: [],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.red,
        ),
      ),
    );
  }
}
