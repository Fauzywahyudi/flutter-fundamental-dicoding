import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restoran_app/api/api_restaurant.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:restoran_app/provider/cek_koneksi.dart';
import 'package:restoran_app/provider/data_shared.dart';

enum FavoriteState { Loading, NoData, HasData, Error, NoConnection }

class FavoriteProvider extends ChangeNotifier {
  final BuildContext context;
  FavoriteProvider(this.context) {
    _fetchDataFavorite();
  }
  final apiService = ApiService();
  final cekConnection = CheckConnection();
  final dataShared = DataShared();

  String _message = '';
  String _query = '';
  FavoriteState _state;
  RestaurantResult _restaurantResult;
  List<Restaurant> _listRestaurant;

  String get message => _message;
  String get query => _query;
  FavoriteState get state => _state;
  RestaurantResult get result => _restaurantResult;
  List<Restaurant> get listRestaurant => _listRestaurant;

  void setQuery(String query) {
    _query = query;
    _fetchDataFavorite();
    notifyListeners();
  }

  Future<Null> refresh() {
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(milliseconds: 500)).then((_) {
      completer.complete();
      _fetchDataFavorite();
      notifyListeners();
    });
    return completer.future;
  }

  Future<dynamic> _fetchDataFavorite() async {
    try {
      _state = FavoriteState.Loading;
      notifyListeners();
      final connection = await cekConnection.checkConnection(context);
      if (!connection.isConnected) {
        _state = FavoriteState.NoConnection;
        notifyListeners();
        return _message = connection.message;
      }
      final restaurant = await dataShared.getAllFavorite();
      if (restaurant.isEmpty) {
        _state = FavoriteState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = FavoriteState.HasData;
        notifyListeners();
        return _listRestaurant = restaurant;
      }
    } catch (e) {
      _state = FavoriteState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future unSetFavorite(Restaurant data) async {
    try {
      final success = await dataShared.unSetDataFavorite(data);
      if (success) _fetchDataFavorite();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
