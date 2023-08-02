import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<dynamic> users = [];
  late SharedPreferences prefs;
  late String token;

  void initState() {
    super.initState();
    fetchUsers();
    _getUserInfoFromToken(); // Call the method to retrieve user info from the token
  }

  Future<void> _getUserInfoFromToken() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    print(token);
  }

  Future register(email) async {
    var regBody = {"email": "$email"};

    var response = await http.post(Uri.parse(url + "/user/follow"),
        headers: {
          "Content-Type": "application/json",
          "accessToken": token,
        },
        body: jsonEncode(regBody));

    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse['status']);
    print(jsonResponse['user']);
  }

  Future<void> fetchUsers() async {
    try {
      final response = await http.post(Uri.parse(url + '/user/getusers'));
      if (response.statusCode == 200) {
        setState(() {
          users = json.decode(response.body);
        });
      } else {
        print('Failed to fetch users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
              title: Text(user['email']),
              subtitle: ElevatedButton(
                onPressed: () {
                  register(user['email']);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal, // Text color of the button
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5, // Elevation of the button
                  shadowColor: Colors.teal.withOpacity(0.4), // Shadow color
                ),
                child: const Text(
                  "Follow",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ));
        },
      ),
    );
  }
}
