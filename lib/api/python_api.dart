import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';

    fetchData(String url, String object) async {
      String? token = await FirebaseMessaging.instance.getToken();
      print('Token: $token');
      var send = {
        "fcm": token,
        "val": object,
      };
      http.Response response = await http.post(
        Uri.parse(url),
        body: send,
      );
      print("sent");
      return json.decode(response.body);
    }