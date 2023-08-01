import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:insta_clone/mainPage.dart'; // Import your MainPage widget
import 'package:insta_clone/pages/homePage.dart'; // Import your HomePage widget
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'YOUR_API_KEY',
        appId: 'YOUR_APP_ID',
        messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
        projectId: 'YOUR_PROJECT_ID',
        storageBucket: 'YOUR_STORAGE_BUCKET',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

   runApp(MyApp(token: prefs.getString('token'),));
}

class MyApp extends StatelessWidget {

  final token;
  const MyApp({
    @required this.token,
    Key? key,
}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (token != null )?HomePage():MainPage()
    );
  }
}