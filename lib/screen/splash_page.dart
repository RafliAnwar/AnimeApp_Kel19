import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/pngwing.com.png',
              width: 400,
            ),
            Text('Anime App', style: GoogleFonts.poppins(fontSize: 25),)
          ],
        ),
      ),
    );
  }
}
