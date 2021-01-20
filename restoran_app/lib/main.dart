import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restoran_app/pages/detail/detail_page.dart';
import 'package:restoran_app/pages/favorite/add_favorite.dart';
import 'package:restoran_app/pages/favorite/favorite.dart';
import 'package:restoran_app/pages/home/home.dart';
import 'package:restoran_app/pages/profile/profile.dart';
import 'package:restoran_app/pages/search/search_page.dart';
import 'package:restoran_app/pages/splashscreen/splashscreen.dart';
import 'package:restoran_app/themes/text_themes.dart';
import 'package:restoran_app/utils/background_service.dart';
import 'package:restoran_app/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

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
        Favorite.routeName: (context) => Favorite(),
        AddFavorite.routeName: (context) => AddFavorite(),
        Profile.routeName: (context) => Profile(),
        DetailPage.routeName: (context) => DetailPage(
              id: ModalRoute.of(context).settings.arguments,
            ),
      },
    );
  }
}
