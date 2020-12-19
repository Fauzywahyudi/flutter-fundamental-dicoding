import 'dart:async';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

class CheckConnection {
  Future<DataConnection> checkConnection(BuildContext context) async {
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
