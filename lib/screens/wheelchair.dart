import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tony_airways/global/TonyColors.dart';
import 'package:tony_airways/global/loading.dart';

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
  String time = "";
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Request a Wheelchair',
                        style: TextStyle(fontSize: 30)),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                        'Please fill out the form below to request a wheelchair for your flight.'),
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
                        labelText: 'Name',
                        labelStyle: TextStyle(color: TonyColors.lightPurple),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: TonyColors.lightPurple),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: TonyColors.lightPurple),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        age = int.parse(val);
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Age',
                        labelStyle: TextStyle(color: TonyColors.lightPurple),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: TonyColors.lightPurple),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: TonyColors.lightPurple),
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
                        labelText: 'Reason',
                        labelStyle: TextStyle(color: TonyColors.lightPurple),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: TonyColors.lightPurple),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: TonyColors.lightPurple),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    TextField(
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          time = value.toString();
                        });
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        // hintText: time == "" ? time : 'Time',
                        labelText: 'Time of Arrival at Airport',
                        labelStyle: TextStyle(color: TonyColors.lightPurple),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: TonyColors.lightPurple),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: TonyColors.lightPurple),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => TonyColors.lightPurple),
                        textStyle: MaterialStateProperty.resolveWith(
                            (states) => TextStyle(
                                // color: TonyColors.black,
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
                        }).catchError(
                                (error) => print("Failed to add user: $error"));
                      },
                      child: Text('Submit'),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
