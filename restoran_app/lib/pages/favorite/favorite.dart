import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/pages/favorite/add_favorite.dart';
import 'package:restoran_app/provider/favorite_provider.dart';
import 'package:restoran_app/themes/text_themes.dart';
import 'package:restoran_app/widget/item_restaurant.dart';

class Favorite extends StatelessWidget {
  static const routeName = '/favorite';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoriteProvider>(
      create: (_) => FavoriteProvider(),
      child: Scaffold(
        floatingActionButton:
            Consumer<FavoriteProvider>(builder: (context, state, _) {
          return FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, AddFavorite.routeName)
                .then((value) {
              if (value != null) state.refresh();
            }),
            child: Icon(Icons.add),
          );
        }),
        body: NestedScrollView(
          headerSliverBuilder: (context, isScroll) {
            return [_buildSliverAppBar(context)];
          },
          body: Consumer<FavoriteProvider>(
            builder: (context, state, _) {
              if (state.state == FavoriteState.Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.state == FavoriteState.HasData) {
                return _buildList(state);
              } else if (state.state == FavoriteState.NoData) {
                return Center(
                  child: Text(state.message, style: labelConnection),
                );
              } else if (state.state == FavoriteState.Error) {
                return Center(
                  child: Text(state.message, style: labelConnection),
                );
              } else if (state.state == FavoriteState.NoConnection) {
                return _buildRefresh(context, state);
              } else {
                return Center(child: Text(''));
              }
            },
          ),
        ),
      ),
    );
  }

  Container _buildRefresh(BuildContext context, FavoriteProvider state) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.message, style: labelConnection),
          SizedBox(height: 30),
          RaisedButton(
            onPressed: state.refresh,
            color: Colors.blue[200],
            child: Text('Refresh'),
          )
        ],
      ),
    );
  }

  Container _buildList(FavoriteProvider state) {
    return Container(
      child: RefreshIndicator(
        onRefresh: state.refresh,
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10),
          itemCount: state.listRestaurant.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                ItemRestaurant(restaurant: state.listRestaurant[index]),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        onPressed: () =>
                            state.unSetFavorite(state.listRestaurant[index]),
                        color: Colors.white,
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Favorites'),
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
            Positioned(
              right: 50,
              top: 50,
              child: Container(
                height: 80,
                width: 80,
                child: Image.asset(
                  'assets/images/favorite.png',
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
