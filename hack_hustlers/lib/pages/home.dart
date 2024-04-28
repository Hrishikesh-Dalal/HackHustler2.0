import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hack_hustlers/authentication/login.dart';
import 'package:hack_hustlers/components/navbar.dart';
import 'package:hack_hustlers/components/bottomNavBar.dart';
import 'package:hack_hustlers/mood_tracker.dart';
import 'package:hack_hustlers/pages/sleep_tracker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _callNumber() async {
    const number = '9152987821'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 34, 96, 203),
        title: const Text(
          'SereneSpace',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          // Place the IconButton within the 'actions' list
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {
              _callNumber();
            },
          ),
        ],
      ),

      body: 
      SleepTrackerPage(),

    );
  }
}
