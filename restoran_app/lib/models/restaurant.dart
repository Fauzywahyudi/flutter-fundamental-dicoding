import 'dart:convert';

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  String menus;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = double.parse(restaurant['rating'].toString());
    menus = jsonEncode(restaurant['menus']);
  }
}

List<Restaurant> parseRestaurants(String json) {
  if (json == null) {
    return [];
  }
  final preParsed = jsonDecode(json);
  final List list = preParsed['restaurants'];
  return list.map((jsonData) => Restaurant.fromJson(jsonData)).toList();
}
