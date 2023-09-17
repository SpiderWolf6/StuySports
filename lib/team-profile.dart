import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamProfile extends StatelessWidget {
  final String title;
  IconData next;
  final String psal_link;

  TeamProfile ({required this.title, required this.next, required this.psal_link});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
        body: Column(
          children: <Widget>[
            const Divider(height: 50),
            Icon(next, size: 100),
            const Divider(height: 10),
            Text("For more information, please see below!"),
            const Divider(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
              children: <Widget> [
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const SizedBox(
                    width: 100,
                    height: 250,
                    child: Center(
                      child: Text(
                        "For player rosters and full game schedule, view the PSAL profile below.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.0,
                          height: 1.25,
                        ),
                      )
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const SizedBox(
                    width: 100,
                    height: 250,
                    child: Center(
                      child: Text(
                        "Stay up to date on everything Stuy Sports at the Spectator!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.0,
                          height: 1.25,
                        ),
                      )
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const SizedBox(
                    width: 100,
                    height: 250,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "Highlights clips, Catapult statistics, and much more are all available at the Sports Management Club's Website!", 
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.0,
                            height: 1.25,
                          ),
                       )
                      )
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
              children: <Widget> [
                InkWell (
                  child: SizedBox (
                    width: 120.0,
                    height: 50.0, 
                    child: ElevatedButton(
                      onPressed: () => _launchURL(psal_link),
                      // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 12.0,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text('PSAL'),
                    ),
                  )
                ),
                InkWell( 
                  child: SizedBox (
                    width: 120.0,
                    height: 50.0, 
                    child: ElevatedButton(
                      onPressed: () => _launchURL("https://stuyspec.com/department/sports"),
                      // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 10, 133, 74),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 12.0,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text('Spec Sports'),
                    ),
                  )
                ),
                InkWell(
                  child: SizedBox(
                    width: 120.0,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () => _launchURL("https://stuyvesantsmc.weebly.com/"),
                      // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 12.0,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text('Stuy SMC'),
                    ),
                  )
                )
              ],
            ),
          ],
        ),
      );
  }
}

_launchURL(link) async {
   final Uri url = Uri.parse(link);
   if (!await launchUrl(url)) {
        throw Exception('Could not launch');
    }
}