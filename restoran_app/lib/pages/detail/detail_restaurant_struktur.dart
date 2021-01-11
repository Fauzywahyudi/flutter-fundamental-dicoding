import 'package:flutter/material.dart';
import 'package:restoran_app/pages/detail/description_restaurant.dart';
import 'package:restoran_app/pages/detail/list_menu_restaurant.dart';
import 'package:restoran_app/pages/detail/name_restaurant.dart';
import 'package:restoran_app/pages/detail/review_costomer.dart';

class ListDetailRestaurant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListView(
        padding: EdgeInsets.only(top: 0),
        children: [
          RestaurantName(),
          RestaurantDescription(),
          ListBuilderMenu(title: 'Makanan'),
          const SizedBox(height: 10),
          ListBuilderMenu(title: 'Minuman'),
          const SizedBox(height: 10),
          ReviewCustomer(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
