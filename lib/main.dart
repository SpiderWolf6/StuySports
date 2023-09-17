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
      title: 'Your Dashboard',
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

#ALTERNATE ORIGINAL LAYOUT, USE FOR REFERENCE
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(primarySwatch: Colors.green),
//         debugShowCheckedModeBanner: false,
//         // home : new ListViewBuilder(),  NO Need To Use Unnecessary New Keyword
//       home: Scaffold(
//           appBar: AppBar(title: const Text('StuySports Test App')),
//           body: const SwitchListTileExample(),
//           ),
//     );
//   }
// }

//  class SwitchListTileExample extends StatefulWidget {
//   const SwitchListTileExample({super.key});

//   @override
//   State<SwitchListTileExample> createState() => _SwitchListTileExampleState();
// }

// class _SwitchListTileExampleState extends State<SwitchListTileExample> {
//   bool switchValue1 = true;
//   bool switchValue2 = true;
//   bool switchValue3 = true;

//   @override
//   Widget build(BuildContext context) {
//     String url = 'http://192.168.1.170:5001/testing';
//     var data;
//     String output = 'Initial Output';
//     late String val = '';

//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           SwitchListTile(
//             value: switchValue1,
//             onChanged: (bool? value) {
//               setState(() {
//                 switchValue1 = value!;
//               });
//               if(switchValue1) [showAlertDialog(context), val = "Soccer", fetchData(url, val)];
//             },
//             title: const Text('Boys Varsity Soccer'),
//             secondary: const Icon(Icons.sports_soccer),
//             subtitle: InkWell (
//               onTap: () {
//                 print("Clicked inkwell");
//               },
//               child: const Text('More info!'),
//             ),          
//           ),
//           const Divider(height: 0),
//           SwitchListTile(
//             value: switchValue2,
//             onChanged: (bool? value) {
//               setState(() {
//                 switchValue2 = value!;
//               });
//               if(switchValue2) [showAlertDialog(context), val = "Basketball", fetchData(url, val)];
//             },
//             title: const Text('Boys Varsity Basketball'),
//             secondary: const Icon(Icons.sports_basketball),
//             subtitle: InkWell (
//               onTap: () {
//                 print("Clicked inkwell");
//               },
//               child: const Text('More info!'),
//             ),          
//           ),
//           const Divider(height: 0),
//           SwitchListTile(
//             value: switchValue3,
//             onChanged: (bool? value) {
//               setState(() {
//                 switchValue3 = value!;
//               });
//               if(switchValue3) [showAlertDialog(context), val = "Baseball", fetchData(url, val)];
//             },
//             title: const Text('Boys Varsity Baseball'),
//             secondary: const Icon(Icons.sports_baseball),
//             subtitle: InkWell (
//               onTap: () {
//                 print("Clicked inkwell");
//               },
//               child: const Text('More info!'),
//             ),
//             isThreeLine: true,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5.0),
//             child: Column(children: [
//               TextField(
//                 onChanged: (value) {
//                   url = "http://192.168.1.170:5001/testing";
//                   val = value.toString();
//                 },
//               ),
//               TextButton(
//                 onPressed: () async {
//                   val = "Everthing";
//                   print(val);
//                   data = await fetchData(url, val);
//                   print(data);
//                   var decoded = jsonDecode(data);
//                   print(decoded);
//                   setState(() {
//                     output = decoded["output"];
//                   });
//                 },
//                 child: Text('Fetch API Value')),
//                 Text(output)
//             ])
//           ),
//           const Divider(
//             thickness: 100.0,
//             height: 100.0,
//           ),
//           Text("Yo how's it going"),
//         ],
//       ),
//     );
//   }
// }

//  showAlertDialog(BuildContext context) {  
//   // Create button  
//   Widget okButton = FloatingActionButton(  
//     child: Text("OK"),  
//     onPressed: () {  
//       Navigator.of(context).pop();  
//     },  
//   );  

//   // Create AlertDialog  
//   AlertDialog alert = AlertDialog(  
//     title: Text("Simple Alert"),  
//     content: Text("You are now following this team."),  
//     actions: [  
//       okButton,  
//     ],  
//   );  

//   // show the dialog  
//   showDialog(  
//     context: context,  
//     builder: (BuildContext context) {  
//       return alert;  
//     },  
//   );  
// }  
