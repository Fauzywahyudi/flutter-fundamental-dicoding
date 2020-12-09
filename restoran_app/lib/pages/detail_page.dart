import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restoran_app/api/api_restaurant.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_restaurant';
  final Restaurant restaurant;
  const DetailPage({@required this.restaurant});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var _data;

  Future getData() async {
    final response = await http.get(ApiService.detail + widget.restaurant.id);
    final data = json.decode(response.body);
    setState(() {
      _data = data;
    });
    print(_data['restaurant']['menus']['foods']);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              MySliverAppBar(
                  id: widget.restaurant.id,
                  pictureId: widget.restaurant.pictureId),
            ];
          },
          body: _buildListView(context),
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          RestaurantName(
            name: widget.restaurant.name,
            city: widget.restaurant.city,
            rating: widget.restaurant.rating,
          ),
          RestaurantDescription(description: widget.restaurant.description),
          _data == null
              ? Container()
              : ListBuilderMenu(
                  data: _data,
                  title: 'Makanan',
                  tipe: 'foods',
                ),
          _data == null
              ? Container()
              : ListBuilderMenu(
                  data: _data,
                  title: 'Minuman',
                  tipe: 'drinks',
                ),
        ],
      ),
    );
  }
}

class MySliverAppBar extends StatelessWidget {
  final String id;
  final String pictureId;
  const MySliverAppBar({@required this.id, @required this.pictureId});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: id,
          child: Image.network(
            ApiService.largeImage + pictureId,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class RestaurantDescription extends StatelessWidget {
  final String description;
  const RestaurantDescription({@required this.description});

  @override
  Widget build(BuildContext context) {
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
              description,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantName extends StatelessWidget {
  final String name;
  final String city;
  final double rating;

  const RestaurantName(
      {@required this.name, @required this.city, @required this.rating});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.headline4.apply(
                    color: Colors.blue,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconText(
                  value: city,
                  color: Colors.red,
                  icon: Icons.location_on,
                ),
                IconText(
                  value: rating.toString(),
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

class IconText extends StatelessWidget {
  final String value;
  final IconData icon;
  final Color color;

  const IconText(
      {@required this.value, @required this.icon, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        SizedBox(width: 5),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}

class ItemListMenu extends StatelessWidget {
  final int index;
  final data;
  final String tipe;

  const ItemListMenu({@required this.index, @required this.data, this.tipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.fastfood,
              size: 70,
              color: Colors.white,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              data['restaurant']['menus'][tipe][index]['name'],
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .apply(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class ListBuilderMenu extends StatelessWidget {
  final String tipe;
  final String title;
  final data;

  const ListBuilderMenu({this.tipe, this.title, this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data['restaurant']['menus'][tipe].length,
                itemBuilder: (context, index) {
                  return ItemListMenu(
                    index: index,
                    tipe: tipe,
                    data: data,
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
