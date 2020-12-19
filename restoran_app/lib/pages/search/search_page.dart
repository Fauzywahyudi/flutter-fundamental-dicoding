import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/provider/restaurant_provider.dart';
import 'package:restoran_app/themes/text_themes.dart';
import 'package:restoran_app/widget/item_restaurant.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _tecSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(context),
      child: Scaffold(body: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.HasData) {
            return Stack(
              children: [
                ListView.builder(
                  padding: EdgeInsets.only(top: kToolbarHeight + 24),
                  shrinkWrap: true,
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (context, index) {
                    return ItemRestaurant(
                        restaurant: state.result.restaurants[index]);
                  },
                ),
                _buildAppBar(context, state),
              ],
            );
          } else if (state.state == ResultState.NoData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.Error) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.NoConnection) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message, style: labelConnection),
                  SizedBox(height: 30),
                  RaisedButton(
                    onPressed: () => state.refresh(),
                    color: Colors.blue[200],
                    child: Text('Refresh'),
                  )
                ],
              ),
            );
          } else {
            return Center(child: Text(''));
          }
        },
      )),
    );
  }

  Container _buildAppBar(BuildContext context, RestaurantProvider state) {
    return Container(
      height: kToolbarHeight + 24,
      padding: EdgeInsets.only(top: 24),
      color: Colors.blue,
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: _tecSearch,
        textInputAction: TextInputAction.search,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
            color: Colors.white,
          ),
          hintText: 'Search..',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        onSubmitted: (value) => state.setQuery(value),
      ),
    );
  }
}
