// ignore_for_file: must_be_immutable, avoid_print, duplicate_ignore, prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home.dart';

import 'authServices.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailControler = TextEditingController();

  TextEditingController passControler = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.amber.shade400,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailControler,
                    decoration: const InputDecoration(
                        labelText: "Email", border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    // keyboardType: TextInputType.,
                    controller: passControler,
                    decoration: const InputDecoration(
                        labelText: "Password", border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  loading
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.amber.shade800,
                          color: Colors.red,
                        )
                      : Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });

                                if (passControler.text == "" ||
                                    emailControler.text == "") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("All fields are required !"),
                                    backgroundColor: Colors.red,
                                  ));
                                } else {
                                  User? result = await AuthServices().login(
                                      emailControler.text,
                                      passControler.text,
                                      context);
                                  if (result != null) {
                                    // ignore: avoid_print
                                    print("Login  Success");
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Login successfully."),
                                      backgroundColor:
                                          Color.fromARGB(255, 57, 54, 244),
                                    ));
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()),
                                        (route) => false);
                                  }
                                }
                                setState(() {
                                  loading = false;
                                });
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 25, fontStyle: FontStyle.italic),
                              )),
                        ),
                ]),
          ),
        ),
      ),
    );
  }
}
