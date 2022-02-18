import 'package:flutter/material.dart';
import 'screen/homeNav.dart';
import 'screen/splash_page.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([//disable landscape orientation
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
