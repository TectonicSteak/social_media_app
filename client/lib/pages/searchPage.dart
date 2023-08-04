import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'allUsers.dart';

//Color Palette
const bgcolor = Color.fromARGB(255, 241, 236, 255);
const textbox_bgcolor = Color.fromARGB(255, 223, 211, 255);

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SharedPreferences prefs;

    void initState() {
    super.initState();
    _getUserInfoFromToken(); // Call the method to retrieve user info from the token
  }

  Future<void> _getUserInfoFromToken() async {
    prefs = await SharedPreferences.getInstance();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              color: textbox_bgcolor,
              child: Center(
                child: Text(
                  "Search Page",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white
                ),
                onPressed: () {Navigator.push(
            context, MaterialPageRoute(builder: (context) =>UserListScreen()));},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                  child: Text("Show all users"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
