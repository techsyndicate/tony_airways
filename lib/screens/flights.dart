import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tony_airways/global/TonyColors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

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
  String originCode = "";
  String destinationCode = "";

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
    return Material(
      // background color
      color: TonyColors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Row(children: [
                Text('Find Flights',
                    style: TextStyle(
                        color: TonyColors.lightPurple,
                        fontSize: 30,
                        fontFamily: "Urbanist")),
                SizedBox(
                  width: 180,
                ),
                Icon(
                  Icons.search,
                  color: TonyColors.lightPurple,
                  size: 30,
                )
              ]),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60.0),
              child: Text('From',
                  style: TextStyle(
                      color: TonyColors.lightPurple,
                      fontSize: 20,
                      fontFamily: "Urbanist")),
            ),
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/images/airplane.svg',
                  height: 30,
                  width: 30,
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(originCode,
                  style: TextStyle(
                      color: TonyColors.neonGreen,
                      fontSize: 20,
                      fontFamily: "Urbanist")),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(color: TonyColors.black),
                  child: DropdownButtonFormField(
                    dropdownColor: TonyColors.black,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                        // background: Paint()..color = TonyColors.black,
                        // backgroundColor: TonyColors.black,
                        color: TonyColors.neonGreen,
                        fontSize: 20,
                        fontFamily: "Urbanist"),
                    items: const [
                      DropdownMenuItem(
                        value: "NYC",
                        child: Text("New York"),
                      ),
                      DropdownMenuItem(
                        value: "LAX",
                        child: Text("Los Angeles"),
                      ),
                      DropdownMenuItem(
                        value: "SFO",
                        child: Text("San Francisco"),
                      ),
                      DropdownMenuItem(
                        value: 'DEL',
                        child: Text('New Delhi'),
                      ),
                      DropdownMenuItem(
                        value: 'BOM',
                        child: Text('Mumbai'),
                      ),
                      DropdownMenuItem(
                        value: 'SYD',
                        child: Text('Sydney'),
                      )
                    ],
                    onChanged: (val) {
                      setState(() {
                        originCode = val.toString();
                      });
                    },
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
