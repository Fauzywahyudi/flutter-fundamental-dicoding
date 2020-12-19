import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/api/api_restaurant.dart';
import 'package:restoran_app/provider/detail_provider.dart';

class MySliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<DetailProvider>(context);
    return SliverAppBar(
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: state.result.restaurant.id,
          child: Image.network(
            ApiService.largeImage + state.result.restaurant.pictureId,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
