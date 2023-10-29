import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zeppos/AddFoodDB.dart';
import 'package:zeppos/chatRoom.dart';
import 'package:zeppos/mealplan.dart';
import 'package:zeppos/settings.dart';

class bottomNavBar extends StatelessWidget {
  const bottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MealPage()));
              },
              icon: const Icon(Icons.apple, color: Colors.white)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.bar_chart, color: Colors.white)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home, color: Colors.white)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatPage()));
              },
              icon: const Icon(Icons.message_outlined, color: Colors.white)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              },
              icon: const Icon(Icons.settings, color: Colors.white)),
        ],
      ),
    );
  }
}
