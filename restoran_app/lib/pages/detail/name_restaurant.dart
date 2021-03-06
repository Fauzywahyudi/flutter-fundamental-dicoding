import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/provider/detail_provider.dart';
import 'package:restoran_app/widget/icon_text.dart';

class RestaurantName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<DetailProvider>(context);
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                state.result.restaurant.name,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconText(
                  value: state.result.restaurant.city,
                  color: Colors.red,
                  icon: Icons.location_on,
                ),
                IconText(
                  value: state.result.restaurant.rating.toString(),
                  color: Colors.yellow,
                  icon: Icons.star,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
