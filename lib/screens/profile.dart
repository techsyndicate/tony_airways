import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tony_airways/global/TonyColors.dart';
import 'package:tony_airways/main.dart';
import 'package:tony_airways/screens/flights.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final firestore = FirebaseFirestore.instance;

class _ProfilePageState extends State<ProfilePage> {
  final auth = FirebaseAuth.instance;
  final users = firestore.collection('users');

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Profile'),
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
    //         SizedBox(
    //           height: 20.0,
    //         ),
    //         const Text('Profile'),
    //         const SizedBox(height: 40),
    //         FutureBuilder(
    //             future: users.doc(auth.currentUser!.email).get(),
    //             builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //               if (snapshot.hasData) {
    //                 var data = snapshot.data!.data() as Map<String, dynamic>;
    //                 return Expanded(
    //                   child: ListView.builder(
    //                     itemCount: data['flights'].length,
    //                     itemBuilder: (context, index) {
    //                       return Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: TextButton(
    //                           onPressed: () {
    //                             Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                     builder: (context) => FlightDetail(
    //                                           flight: Map<String, dynamic>.from(
    //                                               data['flights'][index]),
    //                                         )));
    //                           },
    //                           child: ListTile(
    //                             title: Text(
    //                                 "${data['flights'][index]['itineraries'][0]['segments'][0]['departure']['iataCode']} -> ${data['flights'][index]['itineraries'][0]['segments'][0]['arrival']['iataCode']}"),
    //                             subtitle: Text(
    //                                 "${data['flights'][index]['itineraries'][0]['segments'][0]['departure']['at']} -> ${data['flights'][index]['itineraries'][0]['segments'][0]['arrival']['at']}"),
    //                             shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(10.0),
    //                             ),
    //                             tileColor: Colors.blue,
    //                             textColor: Colors.white,
    //                           ),
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                 );
    //               } else {
    //                 return const Text('Loading...');
    //               }
    //             }),
    //         SizedBox(
    //           height: 20.0,
    //         ),
    //         ElevatedButton(
    //             style: ButtonStyle(
    //               backgroundColor: MaterialStateProperty.all(Colors.blue),
    //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //                 RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(18.0),
    //                 ),
    //               ),
    //             ),
    //             onPressed: () {},
    //             child: Text(
    //               'Find More Flights',
    //               style: TextStyle(color: Colors.white, fontFamily: "Urbanist"),
    //             ))
    //       ],
    //     ),
    //   ),
    // );
    return Material(
      color: TonyColors.black,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(35.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/images/person.svg',
                    height: 40.0,
                  ),
                  FloatingActionButton(
                    backgroundColor: TonyColors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child:
                        SvgPicture.asset("assets/images/cross.svg", height: 50),
                  )
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  Text(
                    "${auth.currentUser!.displayName}",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        fontSize: 35.0,
                        color: TonyColors.lightPurple),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "First Flight with us on 25 Oct '22",
                    style: TextStyle(
                      color: HexColor.fromHex("C9C9C9"),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Text(
                    "Upcoming Flights",
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                  future: users.doc(auth.currentUser!.email).get(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!.data() as Map<String, dynamic>;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: data['flights'].length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                                  backgroundColor: MaterialStateProperty.all(
                                      HexColor.fromHex("161616")),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FlightDetail(
                                                flight:
                                                    Map<String, dynamic>.from(
                                                        data['flights'][index]),
                                              )));
                                },
                                child: ListTile(
                                  tileColor: HexColor.fromHex("161616"),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${data['flights'][index]['itineraries'][0]['segments'][0]['departure']['iataCode']} ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Urbanist'),
                                      ),
                                      Image.asset(
                                        "assets/images/green_plane.png",
                                        height: 25.0,
                                      ),
                                      Text(
                                        "${data['flights'][index]['itineraries'][0]['segments'][0]['arrival']['iataCode']}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Urbanist'),
                                      )
                                    ],
                                  ),
                                  // subtitle: Text(
                                  //     "${data['flights'][index]['itineraries'][0]['segments'][0]['departure']['at']} -> ${data['flights'][index]['itineraries'][0]['segments'][0]['arrival']['at']}"),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),

                                  textColor: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Text('Loading...');
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
