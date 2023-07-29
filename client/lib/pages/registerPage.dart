import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isNotValidate = false;
  final registration = "http://localhost:4000/user/register";

  Future register() async {
    if (confirmedPassword()) {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        var regBody = {
          "email": emailController.text,
          "password": passwordController.text
        };
        print(registration + " mine");
        var response = await http.post(Uri.parse(registration), //connects to db
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(
                regBody)); //the data will be stored in reg body ig, or this will send to the backend for processing

        var jsonResponse = jsonDecode(response.body); //decodes it to get data
        print(jsonResponse['status']);
        print(jsonResponse['message']);

        // if(jsonResponse['status']){
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
        // }
      } else {
        setState(() {
          _isNotValidate = true;
        });
      }
    } else {}
  }

  bool confirmedPassword() {
    if (passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.android,
                  size: 80.0,
                ),
                SizedBox(
                  height: 10,
                ),
                //Hello Text
                Text(
                  "Hello There!",
                  style: GoogleFonts.bebasNeue(fontSize: 50),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Register below with your details.",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                //email textfield
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ),
                ),
                //password textfield
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                      ),
                    ),
                  ),
                ),

                //confirm password textfield
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Confirm Password",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //sign in button
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: register,
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ))),
                    )),
                SizedBox(
                  height: 20,
                ),
                //sign in if you are a member
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text("Sign In",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
