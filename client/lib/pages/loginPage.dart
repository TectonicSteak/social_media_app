import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {

  final VoidCallback shorRegisterPage;
  const LoginPage({super.key, required this.shorRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //Controllers

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim()
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                SizedBox(height: 10,),
                //Hello Text
                Text(
                  "Hello Again!",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 50
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "Welcome back, you\'ve been missed!",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                //email textfield
                SizedBox(height: 60,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ), 
                  ),
                ),
                //password textfield
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                      ),
                    ), 
                  ),
                ),
                SizedBox(height: 20,),
                  
                //sign in button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent, borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                          ),
                        )
                      )
                    ),
                  ) 
                ),
                SizedBox(height: 20,),
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
                    SizedBox(width: 7,),
                    GestureDetector(
                      onTap: widget.shorRegisterPage,
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        )
                      ),
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