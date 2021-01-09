import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/api/api_restaurant.dart';
import 'package:restoran_app/provider/detail_provider.dart';

class MySliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<DetailProvider>(context);
    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: 240,
      pinned: true,
      title: Text(
        state.isShrink ? state.result.restaurant.name : '',
        style: TextStyle(color: Colors.blue),
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(
          color: Colors.blue,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        state.isShrink
            ? CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  color: Colors.blue,
                  icon: Icon(state.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: state.proses
                      ? null
                      : state.isFavorite
                          ? () => state.unSetFavorite(state.result.restaurant)
                          : () => state.setFavorite(state.result.restaurant),
                ),
              )
            : Container(),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Container(
              color: Colors.blue,
              height: 200,
            ),
            SafeArea(
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Hero(
                  tag: state.result.restaurant.id,
                  child: Image.network(
                    ApiService.largeImage + state.result.restaurant.pictureId,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 20,
              child: FloatingActionButton(
                onPressed: state.proses
                    ? null
                    : state.isFavorite
                        ? () => state.unSetFavorite(state.result.restaurant)
                        : () => state.setFavorite(state.result.restaurant),
                backgroundColor: Colors.white,
                child: Icon(
                  state.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
