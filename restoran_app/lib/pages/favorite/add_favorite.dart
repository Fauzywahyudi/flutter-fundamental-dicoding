import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:restoran_app/provider/favorite_provider.dart';
import 'package:restoran_app/provider/restaurant_provider.dart';
import 'package:restoran_app/themes/text_themes.dart';
import 'package:restoran_app/widget/item_restaurant.dart';

class AddFavorite extends StatefulWidget {
  static const routeName = '/add_favorite';
  @override
  _AddFavoriteState createState() => _AddFavoriteState();
}

class _AddFavoriteState extends State<AddFavorite> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
            lazy: true, create: (_) => RestaurantProvider()),
        ChangeNotifierProvider<FavoriteProvider>(
            create: (_) => FavoriteProvider()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Favorite'),
        ),
        body: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              List<Restaurant> newList =
                  selectList(state.result.restaurants, state.listFavorite);
              return ListView.builder(
                shrinkWrap: true,
                itemCount: newList.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ItemRestaurant(restaurant: newList[index]),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: IconButton(
                              onPressed: state.isProses
                                  ? null
                                  : () => state.setFavorite(newList[index]),
                              color: Colors.white,
                              icon: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
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
    );
  }

  List<Restaurant> selectList(
      List<Restaurant> fromData, List<Restaurant> fromFavorite) {
    for (Restaurant favorite in fromFavorite) {
      int i = 0;
      for (Restaurant data in fromData) {
        if (favorite.id == data.id) {
          fromData.removeAt(i);
          break;
        }
        i++;
      }
    }
    return fromData;
  }
}
