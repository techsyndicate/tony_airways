import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tony_airways/global/TonyColors.dart';
import 'package:tony_airways/screens/home.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: TonyColors.lightPurple,
        child: SafeArea(
            child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const HomePage();
                    }));
                  },
                  child: Text(
                    "Home",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 40.0,
                        color: Colors.black),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () {
                    Navigator.pushNamed(context, "/flights/find");
                  },
                  child: Text(
                    "Find Flights",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 40.0,
                        color: Colors.black),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () {
                    Navigator.pushNamed(context, "/membership");
                  },
                  child: Text(
                    "Membership",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 40.0,
                        color: Colors.black),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () {
                    Navigator.pushNamed(context, "/profile");
                  },
                  child: Text(
                    "Profile",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 40.0,
                        color: Colors.black),
                  )),
              FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    "assets/images/black_cross.svg",
                    height: 40.0,
                  ))
            ],
          ),
        )));
  }
}
