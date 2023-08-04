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
        backgroundColor: Colors.deepPurpleAccent,
        leading : IconButton (
          icon : const Icon(Icons.arrow_back),
          onPressed : () {},
        ),
        title : const Text(
          'New Post'
        ),
        centerTitle : false,
        actions: <Widget>[
          TextButton(
            onPressed :() {}, 
            child : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                'Post', 
                style : TextStyle (
                  color : Colors.white,
                  fontWeight : FontWeight.bold,
                  fontSize : 16.0),
                ),
            ),
            ),
          ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Row (
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                //Profile Pic top left
                CircleAvatar (
                  backgroundImage : NetworkImage(
                    'https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80'
                  ),
                  minRadius: 30,
                ),
                //if padding and all required, use container instead
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Container(   
                    //Caption, centre
                    width :  250 ,  //maxWidth * 0.3,
                    child : TextField(
                      decoration : const InputDecoration(
                        hintText : 'Write caption here..',
                        border : InputBorder.none,
                      ),
                      maxLines: 10,
                    ),
                  ),
                ),
                SizedBox (
                  height : 60,
                  width : 60,
                  child : AspectRatio(
                    aspectRatio : 487/451,
                    child : Container(
                      //Upload pic preview, top right
                      decoration : BoxDecoration(
                        image : DecorationImage(
                          image : NetworkImage(
                            'https://images.unsplash.com/photo-1574285013029-29296a71930e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=627&q=80'
                          ), // Image preview of image to be uploaded in post
                            fit : BoxFit.fill,
                            alignment : FractionalOffset.topCenter, 
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(),
              ],
             ),
            ],
          ),
        ),
      ),
    ); 
  }
}