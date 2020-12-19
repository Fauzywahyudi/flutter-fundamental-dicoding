import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/provider/detail_provider.dart';

class RestaurantDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<DetailProvider>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deskripsi',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 10),
            Text(
              state.result.restaurant.description,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
