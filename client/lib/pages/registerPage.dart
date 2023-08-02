import 'dart:convert';
import 'package:insta_clone/auth_page.dart';
import 'package:insta_clone/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';



//Color Palette
const bgcolor = Color.fromARGB(255, 241, 236, 255);
const textbox_bgcolor = Color.fromARGB(255, 223, 211, 255);

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
  final registration = url +  "/user/register";
  late SharedPreferences prefs;

  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  //to get user instance
  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future register() async {
    if (confirmedPassword()) {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        var regBody = {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim()
        };
        print(registration + " mine");
        var response = await http.post(Uri.parse(registration), //connects to db
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(
                regBody)); //the data will be stored in reg body ig, or this will send to the backend for processing

        var jsonResponse = jsonDecode(response.body); //decodes it to get data
        print(jsonResponse['status']);
        print(jsonResponse['user']);
        
        if(jsonResponse['status']){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AuthPage()));
        }
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

                //confirm password textfield
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
                    padding: EdgeInsets.symmetric(horizontal: 100.0),
                    child: GestureDetector(
                      onTap: register,
                      child: Container(
                          padding: EdgeInsets.all(15),
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
