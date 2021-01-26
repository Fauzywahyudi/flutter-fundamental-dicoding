// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class ProfileProvider extends ChangeNotifier {
//   bool _isRemind = false;

//   bool get isRemind => _isRemind;

//   void onChangeRemind(bool value) {
//     _isRemind = value;
//     notifyListeners();
//   }

//   Future<void> showNotification(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         '_channelId', 'Terbaru', 'Ini adalah terbaru',
//         importance: Importance.Max, priority: Priority.High, ticker: 'ticker');

//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();

//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.show(
//         0, 'plain title', 'plain body', platformChannelSpecifics,
//         payload: 'plain notification');
//   }
// }
