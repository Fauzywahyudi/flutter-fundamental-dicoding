import 'package:restoran_app/models/restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataShared {
  static const _dataFavorit = 'dataFavorit';
  // static const _idUser = 'idUser';
  // static const _nama = 'nama';
  // static const _uang = 'uang';

  // Future<bool> getIsNew() async {
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   final isNew = sharedPreferences.getBool(_isNew);
  //   return isNew;
  // }

  // Future<int> getIdUser() async {
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   final idUser = sharedPreferences.getInt(_idUser);
  //   return idUser;
  // }

  Future<bool> setDataFavorite(Restaurant value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final list = await getAllFavorite();
    list.add(value);
    final data = restaurantToJson(list);
    return sharedPreferences.setString(_dataFavorit, data);
  }

  Future<bool> unSetDataFavorite(Restaurant value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final list = await getAllFavorite();
    if (list.isEmpty) return false;
    int i = 0;
    for (Restaurant data in list) {
      if (data.id == value.id) break;
      i++;
    }
    list.removeAt(i);
    final data = restaurantToJson(list);
    return sharedPreferences.setString(_dataFavorit, data);
  }

  Future<List<Restaurant>> getAllFavorite() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final dataJson = sharedPreferences.getString(_dataFavorit);
    if (dataJson == null) return [];
    return restaurantFromJson(dataJson);
  }

  Future<bool> cekFavorite(String id) async {
    final list = await getAllFavorite();
    if (list.isEmpty) return false;
    for (Restaurant data in list) {
      if (data.id == id) return true;
    }
    return false;
  }
}
