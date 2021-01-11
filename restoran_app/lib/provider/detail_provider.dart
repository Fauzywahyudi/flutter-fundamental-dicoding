import 'package:flutter/material.dart';
import 'package:restoran_app/api/api_restaurant.dart';
import 'package:restoran_app/models/detail_restaurant.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:restoran_app/provider/cek_koneksi.dart';
import 'package:restoran_app/provider/data_shared.dart';

enum ResultState { Loading, NoData, HasData, Error, NoConnection }

class DetailProvider extends ChangeNotifier {
  final String id;
  final BuildContext context;

  DetailProvider(this.context, {@required this.id}) {
    _fetchDataDetailRestaurant();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  final apiService = ApiService();
  final cekConnection = CheckConnection();
  final dataShared = DataShared();

  DetailRestaurantResult _detailResult;
  String _message = '';
  ResultState _state;
  ScrollController _controller;
  bool _lastStatus = true;
  bool _proses = false;
  bool _isFavorite = false;

  DetailRestaurantResult get result => _detailResult;
  String get message => _message;
  ResultState get state => _state;
  ScrollController get controller => _controller;
  bool get proses => _proses;
  bool get isFavorite => _isFavorite;
  bool get isShrink =>
      _controller.hasClients && _controller.offset > (220 - kToolbarHeight);
  void _scrollListener() {
    if (isShrink != _lastStatus) {
      _lastStatus = isShrink;
      notifyListeners();
    }
  }

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
      final restaurant = await apiService.getDetailRestaurant(id);
      if (restaurant.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        _detailResult = restaurant;
        cekFavorite();
        notifyListeners();
        return _detailResult;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future setFavorite(Restaurant data) async {
    try {
      _proses = true;
      notifyListeners();
      final success = await dataShared.setDataFavorite(data);
      if (success) _isFavorite = true;
      _proses = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future unSetFavorite(Restaurant data) async {
    try {
      _proses = true;
      notifyListeners();
      final success = await dataShared.unSetDataFavorite(data);
      if (success) _isFavorite = false;
      _proses = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void cekFavorite() async {
    try {
      final isFavorite =
          await dataShared.cekFavorite(_detailResult.restaurant.id);
      if (isFavorite)
        _isFavorite = true;
      else
        _isFavorite = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
