import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tony_airways/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tony_airways/global/TonyColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final firestore = FirebaseFirestore.instance;

class _LoginPageState extends State<LoginPage> {
  final firebaseAuth = FirebaseAuth.instance;
  final users = firestore.collection("users");
  String email = "";
  String pass = "";
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      await users.doc(googleUser.email).set({
        "name": googleUser.displayName,
        "email": googleUser.email,
        "photo": googleUser.photoUrl,
      });
    } catch (e) {
      print(e);
    }

    // Once signed in, return the UserCredential
    return await firebaseAuth.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     appBar: AppBar(
    //         title:
    //             const Text('Login', style: TextStyle(fontFamily: "Urbanist")),
    //         backgroundColor: TonyColors.neonGreen,
    //         elevation: 0),
    //     body: Center(
    //       child:
    //           Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
    //         SizedBox(
    //           height: 80,
    //         ),
    //         Text(
    //           "Login",
    //           style: TextStyle(
    //               color: TonyColors.lightPurple,
    //               fontSize: 30,
    //               fontWeight: FontWeight.bold,
    //               fontFamily: "Urbanist"),
    //         ),
    //         const SizedBox(height: 50),
    //         // google auth
    //         Padding(
    //           padding: const EdgeInsets.all(25.0),
    //           child: ElevatedButton(
    //             style: ButtonStyle(
    //               elevation: MaterialStateProperty.all(0),
    //               fixedSize: MaterialStateProperty.all<Size>(Size(300, 60)),
    //               backgroundColor:
    //                   MaterialStateProperty.all<Color>(Colors.white),
    //               // added rounded borders
    //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //                 RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(10.0),
    //                 ),
    //               ),
    //             ),
    //             onPressed: () async {
    //               try {
    //                 await signInWithGoogle();
    //               } catch (e) {
    //                 print(e);
    //                 // ios error popup
    //                 showDialog(
    //                   context: context,
    //                   builder: (context) {
    //                     return AlertDialog(
    //                       title: const Text('Error'),
    //                       content: const Text('Something went wrong'),
    //                       actions: [
    //                         TextButton(
    //                           onPressed: () {
    //                             Navigator.of(context).pop();
    //                           },
    //                           child: const Text('Ok'),
    //                         ),
    //                       ],
    //                     );
    //                   },
    //                 );
    //               }
    //             },
    //             child: Row(
    //               children: [
    //                 const Image(
    //                     width: 30,
    //                     height: 30,
    //                     image: AssetImage("assets/images/google_logo.png")),
    //                 const SizedBox(width: 50),
    //                 const Text(
    //                   'Sign in with Google',
    //                   style: TextStyle(
    //                       color: Colors.black, fontFamily: "Urbanist"),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         )
    //       ]),
    //     ));
    return Material(
      color: TonyColors.black,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(
                'Login',
                style: TextStyle(
                    color: TonyColors.lightPurple,
                    fontSize: 40.0,
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 70.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                    padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                    backgroundColor:
                        MaterialStateProperty.all(HexColor.fromHex("161616"))),
                child: Text(
                  "Sign in With Google",
                  style: TextStyle(
                      fontFamily: "Urbanist",
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                      color: TonyColors.lightPurple),
                ),
                onPressed: () async {
                  try {
                    await signInWithGoogle();
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
