import 'package:flutter/material.dart';
import 'screen/homeNav.dart';
import 'screen/splash_page.dart';

void main() async {
  runApp(const AnimeApp());
}

class AnimeApp extends StatelessWidget {
  const AnimeApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime app',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/home': (context) => const HomeNav(),
      },
    );
  }
}
