import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'switch-list-tile.dart';
import 'team-profile.dart';
import 'api/firebase_api.dart';
import 'api/python_api.dart';
import 'account-page.dart';

class TileDetail {
  String sport_name;
  String team_name;
  String subtitle;
  IconData next;
  String psal_link;
  TileDetail({required this.sport_name, required this.team_name, required this.subtitle, required this.next, required this.psal_link});
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<TileDetail> tiles = [
    TileDetail(sport_name: 'Soccer', team_name: "Boys Varsity Soccer", subtitle: 'More Info', next: Icons.sports_soccer, psal_link: "https://www.psal.org/profiles/team-profile.aspx#012/02519"),
    TileDetail(sport_name: 'Basketball', team_name: "Boys Varsity Basketball", subtitle: 'More Info!', next: Icons.sports_basketball, psal_link: "https://www.psal.org/profiles/team-profile.aspx#001/02519"),
    TileDetail(sport_name: 'Baseball', team_name: "Boys Varsity Baseball", subtitle: 'More Info!', next: Icons.sports_baseball, psal_link: "https://www.psal.org/profiles/team-profile.aspx#006/02519"),
    TileDetail(sport_name: 'Football', team_name: "Boys Varsity Football", subtitle: 'More Info!', next: Icons.sports_football, psal_link: "https://www.psal.org/profiles/team-profile.aspx#005/02519"),
  ];
  
  final List<Widget> modes = <Widget>[
    Text('Light'),
    Text('Dark'),
  ];

  final List<bool> _selectedMode = <bool>[false, true];
  String selected = "Light";
  var bg = Color.fromRGBO(58, 66, 86, 1.0);
  String url = '';
  var data;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.displayName! + "'s Dashboard"),
        centerTitle: false,
        backgroundColor: Colors.red[200],
        actions: [
          TextButton(
            child: Icon(
              Icons.account_circle_rounded,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountLayout()
                )
              );
            },
          )
        ],
      ),
      backgroundColor: bg,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: tiles.length,
              itemBuilder: (context, index) => SwitchListTileLayout(
                sport_name: tiles[index].sport_name,
                team_name: tiles[index].team_name,
                subtitle: tiles[index].subtitle,
                next: tiles[index].next,
                psal_link: tiles[index].psal_link,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget> [
                ToggleButtons(
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _selectedMode.length; i++) {
                        _selectedMode[i] = i == index;
                      print(_selectedMode);
                      print(index);
                      if (index == 0) {
                        bg = Color.fromRGBO(210, 212, 218, 1);
                      }
                      else {
                        bg = Color.fromRGBO(58, 66, 86, 1.0);
                      }
                      }
                  });
                },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.red[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.red[200],
                  color: Colors.red[400],
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                children: modes, 
                isSelected: _selectedMode
                ),
                ElevatedButton(
                  child: Text('Sign Out'),
                  onPressed: () async {
                    url = "http://192.168.1.170:5001/stuysports1";
                    print(url);
                    data = await fetchData(url, user.email!);
                    print(data);
                    // cards.add(CardDetail(title: "Hello", subtitle:"xyz"));
                    // print(cards);
                    // CardListTile(cards);
                  },
                )
              ],
            ),
          )
        ]
      )
    );
  }
}