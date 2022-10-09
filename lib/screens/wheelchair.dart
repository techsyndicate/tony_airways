import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tony_airways/global/TonyColors.dart';
import 'package:tony_airways/global/loading.dart';
import 'package:tony_airways/main.dart';

class WheelChairForm extends StatefulWidget {
  Map? flight;
  WheelChairForm({Key? key, this.flight}) : super(key: key);

  @override
  State<WheelChairForm> createState() => _WheelChairFormState();
}

class _WheelChairFormState extends State<WheelChairForm> {
  final auth = FirebaseAuth.instance;
  String name = "";
  int age = 0;
  String reason = "";
  String date = "";
  String hour = "";
  String minute = "";
  bool isPM = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loader()
        : Material(
            color: TonyColors.black,
            textStyle:
                TextStyle(color: TonyColors.neonGreen, fontFamily: 'Urbanist'),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/images/wheelchair.svg",
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
                                child:
                                    SvgPicture.asset("assets/images/cross.svg"),
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
                        Text('Request Wheelchair',
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
                      'Please fill out the form below to request a wheelchair for your flight.',
                      style: TextStyle(
                          fontSize: 20, color: HexColor.fromHex("#C9C9C9")),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (val) {
                        name = val;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: 'Name',
                        hintStyle:
                            TextStyle(color: HexColor.fromHex("#C9C9C9")),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: TonyColors.neonGreen),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: TonyColors.neonGreen),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                        onChanged: (val) {
                          reason = val;
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          hintText: 'Reason',
                          hintStyle:
                              TextStyle(color: HexColor.fromHex("#C9C9C9")),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: TonyColors.neonGreen),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: TonyColors.neonGreen),
                          ),
                        )),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 175.0,
                          child: TextFormField(
                            onChanged: (val) {
                              age = int.parse(val);
                            },
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(30.0, 20.0, 0, 20.0),
                              hintText: 'Age',
                              hintStyle:
                                  TextStyle(color: HexColor.fromHex("#C9C9C9")),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide:
                                    BorderSide(color: TonyColors.neonGreen),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide:
                                    BorderSide(color: TonyColors.neonGreen),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 35.0,
                        ),
                        SizedBox(
                          width: 197.0,
                          child: TextField(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2021),
                                lastDate: DateTime(2023),
                              ).then((value) {
                                print(value);
                                setState(() {
                                  date =
                                      "${value!.day}-${value.month}-${value.year}";
                                });
                              });
                            },
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(30.0, 20.0, 0, 20.0),
                              hintText: date == "" ? 'Date' : date,
                              hintStyle:
                                  TextStyle(color: HexColor.fromHex("#C9C9C9")),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide:
                                    BorderSide(color: TonyColors.neonGreen),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide:
                                    BorderSide(color: TonyColors.neonGreen),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 50.0,
                          child: TextFormField(
                            onChanged: (val) {
                              hour = val.toString();
                            },
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: '00',
                              hintStyle:
                                  TextStyle(color: HexColor.fromHex("#C9C9C9")),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide:
                                    BorderSide(color: TonyColors.neonGreen),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide:
                                    BorderSide(color: TonyColors.neonGreen),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          ":",
                          style: TextStyle(
                            color: TonyColors.neonGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        SizedBox(
                          width: 50.0,
                          child: TextFormField(
                            onChanged: (val) {
                              minute = val.toString();
                            },
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: '00',
                              hintStyle:
                                  TextStyle(color: HexColor.fromHex("#C9C9C9")),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide:
                                    BorderSide(color: TonyColors.neonGreen),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide:
                                    BorderSide(color: TonyColors.neonGreen),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isPM = !isPM;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Text(
                                  "am",
                                  style: TextStyle(
                                    color: isPM ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0,
                                  ),
                                ),
                              ),
                              style: ButtonStyle(
                                fixedSize:
                                    MaterialStateProperty.all(Size(5.0, 2.0)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(isPM
                                        ? Colors.transparent
                                        : TonyColors.neonGreen),
                              ),
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isPM = !isPM;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Text(
                                  "pm",
                                  style: TextStyle(
                                    color: isPM ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0,
                                  ),
                                ),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side:
                                        BorderSide(color: TonyColors.neonGreen),
                                  ),
                                ),
                                fixedSize:
                                    MaterialStateProperty.all(Size(5.0, 2.0)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(isPM
                                        ? TonyColors.neonGreen
                                        : Colors.transparent),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              // side: BorderSide(color: TonyColors.neonGreen),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(20.0)),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => TonyColors.lightPurple),
                          textStyle: MaterialStateProperty.resolveWith(
                              (states) => TextStyle(
                                  color: TonyColors.black,
                                  fontFamily: 'Urbanist',
                                  fontSize: 20)),
                        ),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          await FirebaseFirestore.instance
                              .collection('wheelchair')
                              .doc(auth.currentUser!.uid)
                              .set({
                            'name': name,
                            'age': age,
                            'reason': reason,
                            'time': DateTime.now().toString(),
                            "userEmail": auth.currentUser!.email,
                            'flight': widget.flight
                          }).then((value) async {
                            setState(() {
                              loading = false;
                            });
                            await ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                              content: Text('Request Sent!'),
                            ));

                            return Navigator.pop(context);
                          }).catchError((error) =>
                                  print("Failed to add user: $error"));
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40.0,
                            ),
                            Text(
                              'Submit Request',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontSize: 25.0),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: SvgPicture.asset(
                                "assets/images/arrow.svg",
                                height: 10.0,
                                width: 10.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
