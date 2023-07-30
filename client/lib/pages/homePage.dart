import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


//Color Palette
const bgcolor = Color.fromARGB(255, 241, 236, 255);


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      bottomNavigationBar: Container(
        color: Colors.deepPurpleAccent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GNav(
            backgroundColor: Colors.deepPurpleAccent,
            color: Colors.white,
            activeColor: Colors.black,
            tabBackgroundColor: bgcolor,
            gap: 15,
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
            tabs: const[
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.chat,
                text: 'Chat',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
          ]),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("Signed in as " + user!.email!),
            MaterialButton(
              onPressed: (){
                // FirebaseAuth.instance.signOut();
              },
              color: Colors.deepPurpleAccent,
              child: Text("Sign out",style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}