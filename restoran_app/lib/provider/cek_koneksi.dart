import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

class CheckConnection {
  StreamSubscription<DataConnectionStatus> listener;
  var internetStatus = "Unknown";
  var contentmessage = "Unknown";

  void _showDialog(String title, String content, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Connection Status'),
          content: new Text(content),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Close"))
          ],
        );
      },
    );
  }

  Future<DataConnection> checkConnection(BuildContext context) async {
    // listener = DataConnectionChecker().onStatusChange.listen((status) {
    //   switch (status) {
    //     case DataConnectionStatus.connected:
    //       internetStatus = "Connected to the Internet";
    //       contentmessage = "You are connected to the Internet.";
    //       isConnected = true;
    //       // _showDialog(internetStatus, contentmessage, context);
    //       break;
    //     case DataConnectionStatus.disconnected:
    //       internetStatus = "You are disconnected to the Internet. ";
    //       contentmessage = "Please check your internet connection";
    //       isConnected = false;
    //       // _showDialog(internetStatus, contentmessage, context);
    //       break;
    //   }
    // });
    bool isConnected;
    String message = '';
    final connection = await DataConnectionChecker().connectionStatus;
    if (connection == DataConnectionStatus.connected) {
      isConnected = true;
      message = 'You are connected to the Internet';
    } else {
      isConnected = false;
      message = 'You are disconnected to the Internet';
    }
    return DataConnection(isConnected: isConnected, message: message);
  }
}

class DataConnection {
  bool isConnected;
  String message;
  DataConnectionStatus dataConnectionStatus;
  DataConnection({this.isConnected, this.message, this.dataConnectionStatus});
}
