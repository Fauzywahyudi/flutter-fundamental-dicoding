import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restoran_app/api/api_restaurant.dart';
import 'package:restoran_app/models/detail_restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:restoran_app/provider/cek_koneksi.dart';

enum ResultState { Loading, NoData, HasData, Error, NoConnection }

class DetailProvider extends ChangeNotifier {
  final String id;
  final BuildContext context;

  DetailProvider(this.context, {@required this.id}) {
    _fetchDataDetailRestaurant();
  }

  final apiService = ApiService();
  final cekConnection = CheckConnection();

  DetailRestaurantResult _detailResult;
  String _message = '';
  ResultState _state;

  DetailRestaurantResult get result => _detailResult;
  String get message => _message;
  ResultState get state => _state;

  void refresh() {
    _fetchDataDetailRestaurant();
    notifyListeners();
  }

  Future<dynamic> _fetchDataDetailRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final connection = await cekConnection.checkConnection(context);
      if (!connection.isConnected) {
        _state = ResultState.NoConnection;
        notifyListeners();
        return _message = connection.message;
      }
      final restaurant = await getDetailRestaurant();
      if (restaurant.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<DetailRestaurantResult> getDetailRestaurant() async {
    final response = await http.get(ApiService.detail + id);
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Detail Restaurants');
    }
  }
}
