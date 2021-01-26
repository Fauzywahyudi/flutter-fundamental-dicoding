import 'package:restoran_app/models/article.dart';
import 'package:restoran_app/models/detail_restaurant.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static final baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final list = baseUrl + 'list';
  static final detail = baseUrl + 'detail/';
  static final search = baseUrl + 'search?q=';
  static final review = baseUrl + 'review';
  static final smallImage = baseUrl + 'images/small/';
  static final mediumImage = baseUrl + 'images/medium/';
  static final largeImage = baseUrl + 'images/large/';

  Future<RestaurantResult> getDataRestaurant(String query) async {
    String api;
    if (query == null || query == '') {
      api = list;
    } else {
      api = search + query;
    }
    final response = await http.get(api);
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data Restaurant');
    }
  }

  Future<RestaurantResult> getNotifikasiRestaurant() async {
    final response = await http.get(list);
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data Restaurant');
    }
  }

  Future<List<Restaurant>> getSearch(String query) async {
    String api;
    if (query == null || query == '') {
      api = list;
    } else {
      api = search + query;
    }
    final response = await http.get(api);
    if (response.statusCode == 200) {
      final result = RestaurantResult.fromJson(json.decode(response.body));
      return result.restaurants;
    } else {
      throw Exception('Failed to load data Restaurant');
    }
  }

  Future<DetailRestaurantResult> getDetailRestaurant(String id) async {
    final response = await http.get(detail + id);
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Detail Restaurants');
    }
  }

  static final String _baseUrl = 'https://newsapi.org/v2/';
  static final String _apiKey = '81d98da5c83d45a5ad24b6ab1698e745';
  static final String _category = 'business';
  static final String _country = 'id';

  Future<ArticlesResult> topHeadlines() async {
    final response = await http.get(_baseUrl +
        "top-headlines?country=$_country&category=$_category&apiKey=$_apiKey");
    if (response.statusCode == 200) {
      return ArticlesResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
