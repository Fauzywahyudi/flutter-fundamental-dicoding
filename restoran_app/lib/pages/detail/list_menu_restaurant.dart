import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/pages/detail/item_list_menu.dart';
import 'package:restoran_app/provider/detail_provider.dart';

class ListBuilderMenu extends StatelessWidget {
  final String title;

  const ListBuilderMenu({this.title});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<DetailProvider>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 8),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                scrollDirection: Axis.horizontal,
                itemCount: title == "Makanan"
                    ? state.result.restaurant.menus.foods.length
                    : state.result.restaurant.menus.drinks.length,
                itemBuilder: (context, index) {
                  return ItemListMenu(
                    index: index,
                    tipe: title,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
