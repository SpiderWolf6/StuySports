import 'package:flutter/material.dart';
import 'team-profile.dart';
import 'api/firebase_api.dart';
import 'api/python_api.dart';

class SwitchListTileLayout extends StatefulWidget {
  SwitchListTileLayout({ Key? key, required this.sport_name, required this.team_name, required this.subtitle, required this.next, required this.psal_link, required this.int_num, required this.switchValue}): super(key: key);

  final String sport_name;
  final String team_name;
  final String subtitle;
  final int int_num;
  IconData next;
  final String psal_link;
  late String val = '';
  List<dynamic>? switchValue; 
  String url = 'http://192.168.1.170:5001/stuysports2';

  @override
  State<SwitchListTileLayout> createState() => _SwitchListTileLayout();
}

class _SwitchListTileLayout extends State<SwitchListTileLayout>{

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: widget.switchValue?[widget.int_num],
      onChanged: (bool value) {        
        setState(() {
          widget.switchValue?[widget.int_num] = value;
          if (value) {
            showAlertDialog(context);
          }
        });
      },
      title: Text(widget.team_name),
      secondary: Icon(widget.next),
      subtitle: InkWell (
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeamProfile(title: widget.team_name, next: widget.next, psal_link: widget.psal_link)
            )
          );
        },
        child: Text(widget.subtitle),
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