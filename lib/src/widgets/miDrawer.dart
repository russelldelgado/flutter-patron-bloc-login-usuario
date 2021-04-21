

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget retornarDrawable(){

  return Drawer(
    child: SafeArea(
          child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://pbs.twimg.com/media/D6A4qXhWAAEi4-h.jpg")
                ,fit: BoxFit.cover
              ),
              color: Colors.deepPurple),
            child: Container(
              height: 300.0,
              width: double.infinity,
              
            )),

            ListTile(
              leading: Icon(Icons.public),
              title: Text("Product"),
            ),

             ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text("Money"),
            ),

             ListTile(
              leading: Icon(Icons.chat),
              title: Text("Chat"),
            ),

            Expanded(child: SizedBox(width: double.infinity,)),

             ListTile(
                leading: Icon(Icons.close),
                title: Text("Close"),
            ),
        ],
      ),
    ),
  );

}