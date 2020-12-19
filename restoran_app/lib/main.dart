import 'package:flutter/material.dart';
import 'package:restoran_app/pages/detail/detail_page.dart';
import 'package:restoran_app/pages/home/home.dart';
import 'package:restoran_app/pages/search/search_page.dart';
import 'package:restoran_app/pages/splashscreen/splashscreen.dart';
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
        SearchPage.routeName: (context) => SearchPage(),
        DetailPage.routeName: (context) => DetailPage(
              id: ModalRoute.of(context).settings.arguments,
            ),
      },
    );
  }
}
