import 'package:flutter/material.dart';
import 'team-profile.dart';
import 'api/firebase_api.dart';
import 'api/python_api.dart';

class SwitchListTileLayout extends StatelessWidget{
  final String sport_name;
  final String team_name;
  final String subtitle;
  IconData next;
  final String psal_link;
  late String val = '';
  String url = 'http://192.168.1.170:5001/stuysports2';

  SwitchListTileLayout({required this.sport_name, required this.team_name, required this.subtitle, required this.next, required this.psal_link});

  @override
  Widget build(BuildContext context) {
    bool switchValue1 = true;
    return SwitchListTile(
      value: switchValue1,
      onChanged: (bool? value) {},
      title: Text(team_name),
      secondary: Icon(next),
      subtitle: InkWell (
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeamProfile(title: this.team_name, next: this.next, psal_link: this.psal_link)
            )
          );
        },
        child: Text(subtitle),
      ),          
    );
  }

  showAlertDialog(BuildContext context) {  
  // Create button  
    Widget okButton = FloatingActionButton(  
      child: Text("OK"),  
      onPressed: () {  
        Navigator.of(context).pop();  
      },  
    );  

    AlertDialog alert = AlertDialog(  
      title: Text("Simple Alert"),  
      content: Text("You are now following this team."),  
      actions: [  
        okButton,  
      ],  
    );  
  
  // show the dialog  
    showDialog(  
      context: context,  
      builder: (BuildContext context) {  
        return alert;  
      },  
    );  
  }
}