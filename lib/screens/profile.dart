import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),
            const Text('Profile'),
            const SizedBox(height: 40),
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
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {},
                              child: ListTile(
                                title: Text(
                                    "${data['flights'][index]['itineraries'][0]['segments'][0]['departure']['iataCode']} -> ${data['flights'][index]['itineraries'][0]['segments'][0]['arrival']['iataCode']}"),
                                subtitle: Text(
                                    "${data['flights'][index]['itineraries'][0]['segments'][0]['departure']['at']} -> ${data['flights'][index]['itineraries'][0]['segments'][0]['arrival']['at']}"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                tileColor: Colors.blue,
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
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Find More Flights',
                  style: TextStyle(color: Colors.white, fontFamily: "Urbanist"),
                ))
          ],
        ),
      ),
    );
  }
}
