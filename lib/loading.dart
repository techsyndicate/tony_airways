import 'package:flutter/material.dart';
import 'package:tony_airways/main.dart';
import 'package:tony_airways/global/TonyColors.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: CircularProgressIndicator(
          color: TonyColors.ts,
        ),
      ),
    );
  }
}
