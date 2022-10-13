import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tony_airways/global/TonyColors.dart';
import 'package:tony_airways/global/loading.dart';
import 'package:tony_airways/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tony_airways/screens/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = FirebaseAuth.instance;
  final users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Home'),
    //     actions: [
    //       IconButton(
    //         icon: const Icon(Icons.logout),
    //         onPressed: () {
    //           FirebaseAuth.instance.signOut();
    //         },
    //       )
    //     ],
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         const Text('Home'),
    //         const SizedBox(height: 40),
    //         ElevatedButton(
    //           onPressed: () {
    //             Navigator.pushNamed(context, '/flights/find');
    //           },
    //           child: const Text('Find Flights'),
    //         ),
    //         SizedBox(
    //           height: 20.0,
    //         ),
    //         ElevatedButton(
    //           onPressed: () {
    //             Navigator.pushNamed(context, '/profile');
    //           },
    //           child: const Text('Profile'),
    //         ),
    //         SizedBox(
    //           height: 20.0,
    //         ),
    //         ElevatedButton(
    //           onPressed: () {
    //             Navigator.pushNamed(context, '/membership');
    //           },
    //           child: const Text('Membership'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(auth.currentUser!.email).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Material(
            color: TonyColors.black,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            "assets/images/home.svg",
                            height: 35.0,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                            },
                            backgroundColor: TonyColors.black,
                            child: SvgPicture.asset("assets/images/cross.svg"),
                          )
                        ]),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "Welcome ${auth.currentUser!.displayName.toString().split(" ")[0]}",
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                              color: TonyColors.lightPurple,
                              fontSize: 35.0),
                        ),
                      ],
                    ),
                    SvgPicture.asset("assets/images/calender.svg"),
                    SvgPicture.asset(
                      "assets/images/map.svg",
                      height: 250.0,
                      width: 300.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Travel Logs',
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w300,
                              fontSize: 30.0,
                              color: TonyColors.lightPurple),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: HexColor.fromHex("161616"),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${data['flights'][0]['itineraries'][0]['segments'][0]['departure']['iataCode']}",
                              style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
                                  color: Colors.white),
                            ),
                            Image.asset(
                              "assets/images/green_plane.png",
                              height: 20.0,
                            ),
                            Text(
                              "${data['flights'][0]['itineraries'][0]['segments'][0]['arrival']['iataCode']}",
                              style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                                '${data['flights'][0]['itineraries'][0]['segments'][0]['departure']['at'].toString().substring(11, 16)}',
                                style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15.0,
                                    color: TonyColors.neonGreen)),
                            Text(
                              "${data['flights'][0]['itineraries'][0]['segments'][0]['departure']['at'].toString().substring(0, 10)}",
                              style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15.0,
                                  color: TonyColors.neonGreen),
                            ),
                            Text(
                                '${data['flights'][0]['itineraries'][0]['segments'][0]['arrival']['at'].toString().substring(11, 16)}',
                                style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15.0,
                                    color: TonyColors.neonGreen)),
                          ],
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FloatingActionButton(
                      backgroundColor: TonyColors.lightPurple,
                      child: Icon(
                        Icons.menu,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => NavBar()));
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Loader();
      },
    );
  }
}
