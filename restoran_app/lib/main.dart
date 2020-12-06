import 'package:flutter/material.dart';
import 'package:restoran_app/pages/detail_page.dart';
import 'package:restoran_app/pages/home.dart';
import 'package:restoran_app/pages/splashscreen.dart';
import 'package:restoran_app/themes/text_themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restoran App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: myTextTheme,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomePage.routeName: (context) => HomePage(),
        DetailPage.routeName: (context) => DetailPage(
              restaurant: ModalRoute.of(context).settings.arguments,
            ),
      },
    );
  }
}
