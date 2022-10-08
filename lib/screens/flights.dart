import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tony_airways/global/TonyColors.dart';
import 'package:http/http.dart' as http;

class FindFlights extends StatefulWidget {
  const FindFlights({Key? key}) : super(key: key);

  @override
  State<FindFlights> createState() => _FindFlightsState();
}

final firestore = FirebaseFirestore.instance;

class _FindFlightsState extends State<FindFlights> {
  final users = firestore.collection("users");
  final flights = firestore.collection("flights");
  String token = "";

  Future<String?> authAPI() async {
    try {
      var url = "https://test.api.amadeus.com/v1/security/oauth2/token";
      var api_key = dotenv.env['AIR_API_KEY'];
      var api_secret = dotenv.env['AIR_API_SECRET'];
      var response = await http.post(Uri.parse(url), body: {
        "grant_type": "client_credentials",
        "client_id": api_key,
        "client_secret": api_secret
      });
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Text('Find Flights',
                style: TextStyle(
                    color: TonyColors.c1,
                    fontSize: 30,
                    fontFamily: "Urbanist")),
          ],
        ),
      ),
    );
  }
}
