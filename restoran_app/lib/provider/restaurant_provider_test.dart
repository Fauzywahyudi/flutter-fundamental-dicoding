import 'package:flutter/material.dart';
import 'package:restoran_app/models/detail_restaurant.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:restoran_app/provider/cek_koneksi.dart';
import 'package:restoran_app/provider/data_shared.dart';

enum ResultState { Loading, NoData, HasData, Error, NoConnection }
enum FavoriteState { Loading, NoData, HasData, Error, NoConnection }

class RestaurantProviderTest extends ChangeNotifier {
  RestaurantProviderTest({@required this.apiService}) {
    _fetchDataFavorite();
    fetchDataRestaurant();
  }
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final apiService;
  final cekConnection = CheckConnection();
  final dataShared = DataShared();

  String _message = '';
  String _query = '';
  bool _isProses = false;
  ResultState _state;
  FavoriteState _favoriteState;
  RestaurantResult _restaurantResult;
  DetailRestaurantResult _detailResult;
  Restaurant _getDetailRestaurant;

  List<Restaurant> _listFavorite;

  bool get isProses => _isProses;
  String get message => _message;
  String get query => _query;
  ResultState get state => _state;
  FavoriteState get favoriteState => _favoriteState;
  RestaurantResult get result => _restaurantResult;
  List<Restaurant> get listFavorite => _listFavorite;

  Restaurant get detailRestaurant => _getDetailRestaurant;

  void setQuery(String query) {
    _query = query;
    fetchDataRestaurant();
    notifyListeners();
  }

  void refresh() {
    _query = query;
    fetchDataRestaurant();
    notifyListeners();
  }

  Future<dynamic> fetchDataRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final connection =
          await cekConnection.checkConnection(navigatorKey.currentContext);
      if (!connection.isConnected) {
        _state = ResultState.NoConnection;
        notifyListeners();
        return _message = connection.message;
      }
      final restaurant = await apiService.getDataRestaurant(query);
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

  Future<dynamic> _fetchDataFavorite() async {
    try {
      _state = ResultState.Loading;
      _favoriteState = FavoriteState.Loading;
      notifyListeners();
      final connection =
          await cekConnection.checkConnection(navigatorKey.currentContext);
      if (!connection.isConnected) {
        _favoriteState = FavoriteState.NoConnection;
        notifyListeners();
        return _message = connection.message;
      }
      final restaurant = await dataShared.getAllFavorite();
      if (restaurant.isEmpty) {
        _favoriteState = FavoriteState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _favoriteState = FavoriteState.HasData;
        notifyListeners();
        return _listFavorite = restaurant;
      }
    } catch (e) {
      _favoriteState = FavoriteState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future setFavorite(Restaurant data) async {
    try {
      _isProses = true;
      notifyListeners();
      await fetchDataDetailRestaurant(data.id);
      final success = await dataShared.setDataFavorite(detailRestaurant);
      if (success) Navigator.pop(navigatorKey.currentContext, true);
      _isProses = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> fetchDataDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final connection =
          await cekConnection.checkConnection(navigatorKey.currentContext);
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
        _getDetailRestaurant = restaurant.restaurant;
        notifyListeners();
        return _detailResult;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
