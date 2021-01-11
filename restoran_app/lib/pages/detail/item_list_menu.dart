import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/provider/detail_provider.dart';

class ItemListMenu extends StatelessWidget {
  final int index;
  final String tipe;

  const ItemListMenu({@required this.index, @required this.tipe});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<DetailProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.fastfood,
              size: 70,
              color: Colors.blue,
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Text(
              tipe == "Makanan"
                  ? state.result.restaurant.menus.foods[index].name
                  : state.result.restaurant.menus.drinks[index].name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.blue, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
