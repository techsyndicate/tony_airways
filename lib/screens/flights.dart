import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tony_airways/global/TonyColors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tony_airways/global/loading.dart';
import 'package:tony_airways/main.dart';
import 'dart:convert';

import 'package:tony_airways/screens/home.dart';
import 'package:tony_airways/screens/wheelchair.dart';

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
                  SizedBox(
                    height: 20.0,
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
      color: TonyColors.black,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/images/search.svg",
                        height: 30.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 300.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        backgroundColor: TonyColors.black,
                        child: SvgPicture.asset("assets/images/cross.svg"),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 60.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 37.0,
                ),
                Text('Search Results',
                    style: TextStyle(
                        fontSize: 30,
                        color: TonyColors.lightPurple,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Click on a result for more information',
              style:
                  TextStyle(fontSize: 20, color: HexColor.fromHex("#C9C9C9")),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30.0,
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(HexColor.fromHex("#171717")),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        // side: BorderSide(color: TonyColors.lightPurple),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Row(
                      children: [
                        Text(
                          "Time",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Urbanist",
                              fontSize: 20),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        SvgPicture.asset(
                          "assets/images/sort.svg",
                          height: 25.0,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 26.7,
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(HexColor.fromHex("#171717")),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        // side: BorderSide(color: TonyColors.lightPurple),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Row(
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Urbanist",
                              fontSize: 20),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        SvgPicture.asset(
                          "assets/images/sort.svg",
                          height: 25.0,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 26.7,
                ),
                SvgPicture.asset("assets/images/filter.svg", height: 25.0),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView.builder(
                // shrinkWrap: true,
                itemCount: widget.flights!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: TonyColors.black,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border(
                              top: BorderSide(
                                  color: HexColor.fromHex("#c9c9c9"),
                                  width: 1.0))),
                      child: Column(
                        children: [Text("hello")],
                      ),
                    ),
                  );
                },
              ),
            )
            // ListView.builder(
            //   itemCount: widget.flights!.length,
            //   itemBuilder: (context, index) {
            //     return Container(
            //       decoration: BoxDecoration(
            //         border: Border(
            //           top: BorderSide(
            //             color: HexColor.fromHex("#C9C9C9"),
            //             width: 1.0,
            //           ),
            //         ),
            //       ),
            //       child: Column(
            //         children: [
            //           Text(
            //               '${widget.flights![index]['itineraries'][0]['segments'][0]['departure']['iataCode']} - ${widget.flights![index]['itineraries'][0]['segments'][0]['arrival']['iataCode']}'),
            //         ],
            //       ),
            //     );
            //   },
            // ),
          ],
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flight Booked'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return HomePage();
                  },
                ));
              },
              child: Text('Home'),
            )
          ],
        ),
      ),
    );
  }
}

class FlightDetail extends StatefulWidget {
  Map? flight;
  FlightDetail({Key? key, this.flight}) : super(key: key);

  @override
  State<FlightDetail> createState() => _FlightDetailState();
}

class _FlightDetailState extends State<FlightDetail> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: TonyColors.black,
      textStyle: TextStyle(color: TonyColors.neonGreen, fontFamily: 'Urbanist'),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text('Flight Details'),
            SizedBox(
              height: 20.0,
            ),
            Text(
                "${widget.flight!['itineraries'][0]['segments'][0]['departure']['iataCode']} - ${widget.flight!['itineraries'][0]['segments'][0]['arrival']['iataCode']}"),
            SizedBox(
              height: 20.0,
            ),
            Text("${widget.flight!['price']['total']}"),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return WheelChairForm(
                        flight: Map<String, dynamic>.from(widget.flight!));
                  },
                ));
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(TonyColors.lightPurple),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
              ),
              child: Container(
                height: 100.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.wheelchair_pickup,
                        color: TonyColors.neonGreen,
                        size: 40.0,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Request Wheelchair",
                        style: TextStyle(
                            fontFamily: 'Urbanist',
                            color: TonyColors.neonGreen,
                            fontSize: 30.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(TonyColors.lightPurple),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
              ),
              child: Container(
                height: 100.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.wifi,
                        color: TonyColors.neonGreen,
                        size: 40.0,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Internet Access",
                        style: TextStyle(
                            fontFamily: 'Urbanist',
                            color: TonyColors.neonGreen,
                            fontSize: 30.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
