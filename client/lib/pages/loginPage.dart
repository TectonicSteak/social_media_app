import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_clone/pages/registerPage.dart';
import 'package:insta_clone/pages/homePage.dart';

//Color Palette
const bgcolor = Color.fromARGB(255, 241, 236, 255);
const textbox_bgcolor = Color.fromARGB(255, 223, 211, 255);

class LoginPage extends StatefulWidget {
  final VoidCallback shorRegisterPage;
  const LoginPage({super.key, required this.shorRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Controllers

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final login = "http://localhost:4000/user/login";
 
  

  


  Future signIn() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text
      };

      var response = await http.post(Uri.parse(login), //api call to login
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var test = jsonResponse['test'];
        print(test);
        var myToken = jsonResponse[
            'token']; //token send from the back end containing all the user data
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage()));
        Fluttertoast.showToast(
          msg: 'sign in successfull',
          toastLength: Toast
              .LENGTH_SHORT, // Duration the toast will be visible on the screen
          gravity: ToastGravity
              .BOTTOM, // Location where the toast will appear on the screen
          timeInSecForIosWeb: 1, // Time for iOS, ignored on Android
          backgroundColor: Colors.black, // Background color of the toast
          textColor: Colors.white, // Text color of the toast
          fontSize: 16.0, // Font size for the toast message
        );
      } else {
        Fluttertoast.showToast(
          msg: 'sign in failed',
          toastLength: Toast
              .LENGTH_SHORT, // Duration the toast will be visible on the screen
          gravity: ToastGravity
              .BOTTOM, // Location where the toast will appear on the screen
          timeInSecForIosWeb: 1, // Time for iOS, ignored on Android
          backgroundColor: Colors.black, // Background color of the toast
          textColor: Colors.white, // Text color of the toast
          fontSize: 16.0, // Font size for the toast message
        );
      }
    }
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
      backgroundColor: bgcolor,
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
                  "Hello Again!",
                  style: GoogleFonts.bebasNeue(fontSize: 50),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Welcome back, you\'ve been missed!",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                //email textfield
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 75.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: textbox_bgcolor,
                        border: Border.all(color: Colors.deepPurpleAccent),
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
                  padding: const EdgeInsets.symmetric(horizontal: 75.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: textbox_bgcolor,
                        border: Border.all(color: Colors.deepPurpleAccent),
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
                SizedBox(
                  height: 20,
                ),
                //sign in button
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100.0),
                    child: GestureDetector(
                      onTap: signIn,
                      child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ))),
                    )),
                SizedBox(
                  height: 20,
                ),
                //sign up if not a member
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    GestureDetector(
                      onTap: widget.shorRegisterPage,
                      child: Text("Register Now",
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
