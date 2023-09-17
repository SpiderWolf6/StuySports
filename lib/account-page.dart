import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountLayout extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Account Info"),
      ),
      body: Column(
        children: <Widget>[
          const Divider(height: 50),
          CircleAvatar(radius: 40, backgroundImage: NetworkImage(user.photoURL!)),
          const Divider(height: 50),
          Text("Name: " + user.displayName!),
          const Divider(height: 30),
          Text("Email: " + user.email!),
          const Divider(height: 250),
          SizedBox(
            height: 100,
            width: 100,
            child: TextButton (
              onPressed: () {
                print("signed out");
              }, 
              child: Text("Sign Out", ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  elevation: 12.0,
              )
            )
          )
        ],
      )
    );
  }
}