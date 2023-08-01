import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:insta_clone/auth_page.dart';
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

  void initState() {
    super.initState();
    _getUserInfoFromToken(); // Call the method to retrieve user info from the token
  }

  Future<void> _getUserInfoFromToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token =
        prefs.getString('token'); // Get the token from shared preferences

    if (token != null) {
      // Decode the token
      Map<String, dynamic> jwtDecodeToken = JwtDecoder.decode(token);

      // Get user information from the decoded token
      String? email = jwtDecodeToken['email'];
      print(email);
      print(
          "helllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll0");

      // Use the user information as needed (e.g., store it in state variables)
      setState(() {
        this.email = email!;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 100,
              color: textbox_bgcolor,
              child: Center(
                child: Text(
                  "Settings Page",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                child: ElevatedButton(
                  onPressed: () {
                    clearJwtToken();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AuthPage()));
                  },
                  child: Text("sign out"),
                ),
              ),
            ),
            Container(
              child: Text(email),
            )
          ],
        ),
      ),
    );
  }
}
