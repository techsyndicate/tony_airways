import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tony_airways/global/TonyColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tony_airways/main.dart';

class MemberShip extends StatefulWidget {
  const MemberShip({Key? key}) : super(key: key);

  @override
  State<MemberShip> createState() => _MemberShipState();
}

class _MemberShipState extends State<MemberShip> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: TonyColors.black,
      child: SafeArea(
          child: Container(
        padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/images/card.svg",
                      height: 40.0,
                    ),
                    FloatingActionButton(
                      backgroundColor: TonyColors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        "assets/images/cross.svg",
                        height: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Hi, ${auth.currentUser!.displayName}',
                    style: TextStyle(
                        fontFamily: "Urbanist",
                        color: TonyColors.lightPurple,
                        fontSize: 30.0),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Text(
                    'Please choose your plan',
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 20.0,
                        color: HexColor.fromHex("C9C9C9")),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                height: 230.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: HexColor.fromHex("222222"),
                ),
                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "VIP",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        ),
                        SvgPicture.asset(
                          'assets/images/star.svg',
                          height: 30.0,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Our most premium plan for our most elite and loyal customers. Get access to all our services and more.",
                      style: TextStyle(
                          color: HexColor.fromHex("5A5A5A"),
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(10, 10, 10, 10)),
                            backgroundColor: MaterialStateProperty.all(
                                HexColor.fromHex("383838")),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            )),
                          ),
                          onPressed: () {
                            print('hello');
                            Navigator.pushNamed(context, "/vip");
                          },
                          child: Text(
                            'Learn More',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                height: 230.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: HexColor.fromHex("C8FF29"),
                ),
                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tony Gold",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black),
                        ),
                        SvgPicture.asset(
                          'assets/images/crown.svg',
                          height: 30.0,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "The plan for those who like to live in luxury. Fly with our most premium airlines and get access to most of our services.",
                      style: TextStyle(
                          color: HexColor.fromHex("678A03"),
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(10, 10, 10, 10)),
                            backgroundColor: MaterialStateProperty.all(
                                HexColor.fromHex("EBFFB0")),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            )),
                          ),
                          onPressed: () {
                            print('hello');
                            Navigator.pushNamed(context, "/vip");
                          },
                          child: Text(
                            'Learn More',
                            style: TextStyle(
                                color: HexColor.fromHex("6A8713"),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                height: 230.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: HexColor.fromHex("C5AFFF"),
                ),
                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tony Lilac",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black),
                        ),
                        SvgPicture.asset(
                          'assets/images/jewel.svg',
                          height: 30.0,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "The plan for those who dont live the regular life. Get access to a selection of premium services.",
                      style: TextStyle(
                          color: HexColor.fromHex("8878B1"),
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(10, 10, 10, 10)),
                            backgroundColor: MaterialStateProperty.all(
                                HexColor.fromHex("DACCFF")),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            )),
                          ),
                          onPressed: () {
                            print('hello');
                            Navigator.pushNamed(context, "/vip");
                          },
                          child: Text(
                            'Learn More',
                            style: TextStyle(
                                color: HexColor.fromHex("63587E"),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class VIPDetail extends StatefulWidget {
  VIPDetail({Key? key}) : super(key: key);

  @override
  State<VIPDetail> createState() => _VIPDetailState();
}

class _VIPDetailState extends State<VIPDetail> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: TonyColors.black,
      child: SafeArea(
          child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/images/card.svg',
                  height: 40.0,
                ),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: TonyColors.black,
                  child: SvgPicture.asset(
                    "assets/images/cross.svg",
                    height: 40.0,
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
