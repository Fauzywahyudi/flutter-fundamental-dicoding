import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/pages/favorite/favorite.dart';
import 'package:restoran_app/pages/search/search.dart';
import 'package:restoran_app/pages/search/search_page.dart';
import 'package:restoran_app/provider/restaurant_provider.dart';
import 'package:restoran_app/themes/text_themes.dart';
import 'package:restoran_app/widget/item_restaurant.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(context),
      child: NestedScrollView(
        headerSliverBuilder: (context, isScroll) {
          return [_buildSliverAppBar(context)];
        },
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          color: Colors.grey[300],
          child: Consumer<RestaurantProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.HasData) {
                return ListView.builder(
                  padding: EdgeInsets.only(top: 8),
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
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 200,
      leading: CircleAvatar(
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/ikon.png',
                ),
                fit: BoxFit.cover),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.favorite_border),
          tooltip: 'Favofite',
          onPressed: () => Navigator.pushNamed(context, Favorite.routeName),
        ),
        IconButton(
          icon: Icon(Icons.search),
          tooltip: 'Search Restaurant',
          onPressed: () => showSearch(
            context: context,
            delegate: CustomSearchDelegate(),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Restaurant App'),
        background: Stack(
          children: [
            SafeArea(
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/ikon.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Colors.blue.withOpacity(0.4),
              ),
            )
          ],
        ),
      ),
    );
  }
}
