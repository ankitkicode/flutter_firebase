// ignore_for_file: unused_import, prefer_const_constructors, deprecated_member_use, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/register_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool signout = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        backgroundColor: Colors.amber.shade700,
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () {
              // setState(() {
              //   signout = false;
              // });
              _auth.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()));
              // setState(() {
              //   signout = false;
              // });
            },
            icon: Icon(Icons.logout),
            label: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Sing out"),
            ),
            style: TextButton.styleFrom(primary: Colors.white),
          )
        ],
      ),
      body: Center(child: Text("Welcome to Ankit\n ki code")),
    );
  }
}
