import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/pages/search/search_page.dart';
import 'package:restoran_app/provider/restaurant_provider.dart';
import 'package:restoran_app/widget/item_restaurant.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Restaurant App'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () =>
                  Navigator.pushNamed(context, SearchPage.routeName),
            )
          ],
        ),
        body: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.restaurants.length,
                itemBuilder: (context, index) {
                  return ItemRestaurant(
                      restaurant: state.result.restaurants[index]);
                },
              );
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
