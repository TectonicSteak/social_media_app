import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:insta_clone/pages/chatPage.dart';
import 'package:insta_clone/pages/homescreenPage.dart';
import 'package:insta_clone/pages/searchPage.dart';
import 'package:insta_clone/pages/settingsPage.dart';


//Color Palette
const bgcolor = Color.fromARGB(255, 241, 236, 255);


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Widget> pages=[
    HomeScreenPage(),
    SearchPage(),
    Chatpage(),
    SettingsPage()
  ];

  int pageIndex = 0;

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

            selectedIndex: pageIndex,

            onTabChange: (index){
              setState(() {
                pageIndex = index;
              });
            },

            tabs: const[
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
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
      body: pages[pageIndex],
    );
  }
}