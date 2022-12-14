import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tony_airways/screens/flights.dart';
import 'package:tony_airways/screens/member.dart';
import 'package:tony_airways/screens/profile.dart';
import 'package:tony_airways/wrapper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: "./.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        routes: {
          "/flights/find": (context) => const FindFlights(),
          "/flights/view": (context) => ViewFlights(),
          "/flights/confirm": (context) => FlightConfirm(),
          "/profile": (context) => ProfilePage(),
          "/membership": (context) => MemberShip(),
          "/vip": (context) => VIPDetail()
        },
        home: Wrapper());
  }
}
