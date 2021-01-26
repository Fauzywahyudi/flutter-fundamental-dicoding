import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restoran_app/pages/detail/detail_page.dart';
import 'package:restoran_app/pages/home/home.dart';
import 'package:restoran_app/utils/background_service.dart';
import 'package:restoran_app/utils/notification_helper.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashscreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final NotificationHelper _notificationHelper = NotificationHelper();
  // final BackgroundService _service = BackgroundService();

  @override
  void initState() {
    Timer(Duration(seconds: 4),
        () => Navigator.pushReplacementNamed(context, HomePage.routeName));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/ikon.png'),
            Text(
              'Restaurant App',
              style: Theme.of(context).textTheme.headline3,
            )
          ],
        ),
      ),
    );
  }
}
