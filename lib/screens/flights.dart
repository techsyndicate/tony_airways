import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tony_airways/global/TonyColors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tony_airways/global/loading.dart';
import 'dart:convert';

class FindFlights extends StatefulWidget {
  const FindFlights({Key? key}) : super(key: key);

  @override
  State<FindFlights> createState() => _FindFlightsState();
}

final firestore = FirebaseFirestore.instance;

class _FindFlightsState extends State<FindFlights> {
  final users = firestore.collection("users");
  final flights = firestore.collection("flights");
  // String token = "";
  String originCode = "";
  String destinationCode = "";
  bool loading = false;
  String adults = "Number of Adults";
  String depDate = "Deprature Date";

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
      return (response.body.split(":")[6].split(",")[0].replaceAll('"', ''));
    } catch (e) {
      print(e);
    }
  }

  Future<List> getFlights() async {
    try {
      var token = await authAPI();

      var url = Uri.parse(
          "https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=${originCode}&destinationLocationCode=${destinationCode}&departureDate=${depDate}&adults=${adults}&nonStop=true&max=10");

      var response = await http.get(url, headers: {
        "Authorization": "Bearer ${token}",
      });
      return (jsonDecode(response.body)['data']);
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loader()
        : Material(
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
                              value: "JFK",
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
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: Text('To',
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
                    Text(destinationCode,
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
                              destinationCode = val.toString();
                            });
                          },
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 50.0,
                  ),
                  TextField(
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100));

                      setState(() {
                        depDate = "${date!.year}-${date.month}-${date.day}";
                      });
                    },
                    decoration: InputDecoration(
                      hintText: depDate,
                      hintStyle: TextStyle(
                          color: TonyColors.lightPurple,
                          fontSize: 20,
                          fontFamily: "Urbanist"),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: TonyColors.lightPurple,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  TextFormField(
                    onChanged: (val) {
                      adults = val;
                    },
                    style: TextStyle(
                        color: TonyColors.lightPurple,
                        fontSize: 20,
                        fontFamily: "Urbanist"),
                    decoration: InputDecoration(
                      hintText: adults,
                      hintStyle: TextStyle(
                          color: TonyColors.lightPurple,
                          fontSize: 20,
                          fontFamily: "Urbanist"),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.person,
                        color: TonyColors.lightPurple,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        backgroundColor: TonyColors.neonGreen,
                        child: Icon(
                          Icons.arrow_forward,
                          color: TonyColors.black,
                        ),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          try {
                            var flights = await getFlights();
                            setState(() {
                              loading = false;
                            });
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ViewFlights(
                                  flights: flights,
                                );
                              },
                            ));
                          } catch (e) {
                            print(e);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text('Something went wrong'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }
}

class ViewFlights extends StatefulWidget {
  List? flights = [];
  ViewFlights({Key? key, this.flights}) : super(key: key);

  @override
  State<ViewFlights> createState() => _ViewFlightsState();
}

class _ViewFlightsState extends State<ViewFlights> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ListView.builder(
          itemCount: widget.flights!.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                trailing: ElevatedButton(
                  child: Text('Book'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return FlightBook(
                          flight:
                              Map<String, dynamic>.from(widget.flights![index]),
                        );
                      },
                    ));
                  },
                ),
                title: Text(
                    "${widget.flights![index]['itineraries'][0]['segments'][0]['departure']['at']} - ${widget.flights![index]['itineraries'][0]['segments'][0]['arrival']['at']}"),
                subtitle: Text(widget.flights![index]['price']['total']),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FlightBook extends StatefulWidget {
  Map? flight;
  FlightBook({Key? key, this.flight}) : super(key: key);

  @override
  State<FlightBook> createState() => _FlightBookState();
}

class _FlightBookState extends State<FlightBook> {
  final users = firestore.collection("users");
  final flights = firestore.collection("flights");
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
            child: Column(
      children: [
        Text(
            "${widget.flight!['itineraries'][0]['segments'][0]['departure']['iataCode']} - ${widget.flight!['itineraries'][0]['segments'][0]['arrival']['iataCode']}"),
        SizedBox(
          height: 20.0,
        ),
        Text("${widget.flight!['price']['total']}"),
        SizedBox(
          height: 40.0,
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              await flights.add({
                "flight": widget.flight,
              });
              await users.doc(auth.currentUser!.email).update({
                "flights": FieldValue.arrayUnion([widget.flight])
              });
              Navigator.pushNamed(context, "/flights/confirm");
            } catch (e) {
              print(e);
            }
          },
          child: Text('Book Flight'),
        )
      ],
    )));
  }
}

class FlightConfirm extends StatelessWidget {
  const FlightConfirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Center(
          child: Text('Flight Booked'),
        ),
      ),
    );
  }
}
