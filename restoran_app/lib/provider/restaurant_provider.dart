import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:restoran_app/api/api_restaurant.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:restoran_app/provider/cek_koneksi.dart';

enum ResultState { Loading, NoData, HasData, Error, NoConnection }

class RestaurantProvider extends ChangeNotifier {
  final BuildContext context;
  RestaurantProvider(this.context) {
    _fetchDataRestaurant();
  }
  final apiService = ApiService();
  final cekConnection = CheckConnection();

  String _message = '';
  String _query = '';
  ResultState _state;
  RestaurantResult _restaurantResult;

  String get message => _message;
  String get query => _query;
  ResultState get state => _state;
  RestaurantResult get result => _restaurantResult;

  void setQuery(String query) {
    _query = query;
    _fetchDataRestaurant();
    notifyListeners();
  }

  void refresh() {
    _query = query;
    _fetchDataRestaurant();
    notifyListeners();
  }

  Future<dynamic> _fetchDataRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final connection = await cekConnection.checkConnection(context);
      if (!connection.isConnected) {
        _state = ResultState.NoConnection;
        notifyListeners();
        return _message = connection.message;
      }
      final restaurant = await getDataRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<RestaurantResult> getDataRestaurant() async {
    String api;
    if (query == null || query == '') {
      api = ApiService.list;
    } else {
      api = ApiService.search + query;
    }
    final response = await http.get(api);
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data Restaurant');
    }
  }
}
