import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stuy_app/provider/google-sign-in.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'api/firebase_api.dart';
import 'api/python_api.dart';
import 'dashboard.dart';
import 'sign-in-page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => GoogleSignInProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StuyActivities Dashboard',
      theme: ThemeData.dark().copyWith(),
      home: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget{
  @override
  Widget build (BuildContext context) => Scaffold (
    body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return Dashboard();
        } else if (snapshot.hasError) {
          return Center(child: Text('Something Went Wrong!'));
        } else {
          return SignUpWidget();
        }
      },
    )
  );
}
