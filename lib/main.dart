import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:insta_clone/loginPage.dart';
import 'package:insta_clone/mainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAKrv5YIWT5q3wYEDpHRrXmB09b0ELN3XM',
        appId: "1:659085382294:web:8b50f215c23484f34568b7",
        messagingSenderId: "659085382294",
        projectId: "socail-media-app-69316",
        storageBucket: "socail-media-app-69316.appspot.com",)
    );
  }else{
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}