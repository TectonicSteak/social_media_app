import 'dart:convert';
import 'package:flutter/material.dart';

//Color Palette
const bgcolor = Color.fromARGB(255, 241, 236, 255);
const textbox_bgcolor = Color.fromARGB(255, 223, 211, 255);

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
  /* Appear only when image no selected
    return Center(
      child : IconButton (
          icon : const Icon(Icons.upload),
          onPressed : () {},
        ),
    );
    */
    return Scaffold(
      backgroundColor: bgcolor,
      appBar : AppBar(
      leading : IconButton (
        icon : const Icon(Icons.arrow_back),
        onPressed : () {},
      ),
      title : const Text(
        'post to'
      ),
      centerTitle : false,
      actions: <Widget>[
        TextButton(
          onPressed :() {}, 
          child : const Text(
            'Post', 
            style : TextStyle (
              color : Colors.blueAccent,
              fontWeight : FontWeight.bold,
              fontSize : 16.0),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           Row (
            children : [
              CircleAvatar (
                backgroundImage : NetworkImage(
                  'https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80'
                ),
              ),
              //if padding and all required, use container instead
              SizedBox(   
                width :  550 ,  //maxWidth * 0.3,
                child : TextField(
                  decoration : const InputDecoration(
                    hintText : 'Write post desc...',
                    border : InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              ),
            ],
           ),
          ],
        ),
      ),
    ); 
  }
}