import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:restoran_app/api/api_restaurant.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:http/http.dart' as http;

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  // final ApiService apiService;

  RestaurantProvider() {
    _fetchDataRestaurant();
  }
  final apiService = ApiService();

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

  Future<dynamic> _fetchDataRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
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
