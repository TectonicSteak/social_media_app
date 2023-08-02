import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:insta_clone/auth_page.dart';
import 'package:insta_clone/pages/userFollowers.dart';
import 'package:insta_clone/pages/userFollowing.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Color Palette
const bgcolor = Color.fromARGB(255, 241, 236, 255);
const textbox_bgcolor = Color.fromARGB(255, 223, 211, 255);

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String email;
    late SharedPreferences prefs;


  void initState() {
    super.initState();
    _getUserInfoFromToken(); // Call the method to retrieve user info from the token
  }

  Future<void> _getUserInfoFromToken() async {
    prefs = await SharedPreferences.getInstance();
    String? token =
        prefs.getString('token'); // Get the token from shared preferences

    if (token != null) {
      // Decode the token
      Map<String, dynamic> jwtDecodeToken = JwtDecoder.decode(token);

      // Get user information from the decoded token
      //String? email = jwtDecodeToken['email'];
      //print(email);
      print(
          "helllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll0");

      // Use the user information as needed (e.g., store it in state variables)
      setState(() {
        //this.email = email!;
      });
    } else {
      // Handle the case where the token is null (e.g., user is not authenticated)
    }
  }

  Future<void> clearJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left:0.0,top:30.0,right:0.0,bottom:0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white
                  ),
                    onPressed: () {
                      clearJwtToken();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AuthPage()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                      child: Text("sign out"),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white
                  ),
                  onPressed: () {Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>Followers()));},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                    child: Text("followers"),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white
                  ),
                  onPressed: () {Navigator.push(
              context, MaterialPageRoute(builder: (context) =>Following( token: prefs.getString('token'),)));},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                    child: Text("following"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
