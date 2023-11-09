// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_constructors_in_immutables, sized_box_for_whitespace, duplicate_ignore, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/authServices.dart';
import 'package:flutter_firebase/screens/home.dart';
import 'package:flutter_firebase/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailControler = TextEditingController();

  TextEditingController passwordControler = TextEditingController();

  TextEditingController confirmpassControler = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.amber.shade400,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailControler,
                  decoration: InputDecoration(
                      labelText: "Email", border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  // keyboardType: TextInputType.number,
                  controller: passwordControler,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: confirmpassControler,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                // ignore: sized_box_for_whitespace
                loading
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.amber.shade900,
                        color: Colors.red.shade400,
                      )
                    : Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              //register logics////
                              if (passwordControler.text == "" ||
                                  emailControler.text == "") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("All fields are required !"),
                                  backgroundColor: Colors.red,
                                ));
                              } else if (passwordControler.text !=
                                  confirmpassControler.text) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Password don't match !"),
                                  backgroundColor: Colors.red,
                                ));
                              } else {
                                User? result = await AuthServices().register(
                                    emailControler.text,
                                    passwordControler.text,
                                    context);
                                if (result != null) {
                                  print("Success");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        "Registered successfully, Try to Login !"),
                                    backgroundColor:
                                        Color.fromARGB(255, 57, 54, 244),
                                  ));
                                }
                              }
                              setState(() {
                                loading = false;
                              });
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  fontSize: 20, fontStyle: FontStyle.italic),
                            )),
                      ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text("Already,have an account? Login here",
                        style: TextStyle(
                          fontSize: 15,
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
