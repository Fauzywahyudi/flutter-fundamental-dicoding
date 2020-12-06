import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restoran_app/models/restaurant.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_restaurant';
  final Restaurant restaurant;
  const DetailPage({@required this.restaurant});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List foods() {
    final preParsed = jsonDecode(widget.restaurant.menus.toString());
    final List list = preParsed['foods'];
    return list;
  }

  List drinks() {
    final preParsed = jsonDecode(widget.restaurant.menus.toString());
    final List list = preParsed['drinks'];
    return list;
  }

  @override
  void initState() {
    foods();
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
              SliverAppBar(
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: widget.restaurant.id,
                    child: Image.network(
                      widget.restaurant.pictureId,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Container(
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.restaurant.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .apply(color: Colors.blue),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  widget.restaurant.city,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  widget.restaurant.rating.toString(),
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
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
                          widget.restaurant.description,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Makanan',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: foods().length,
                            itemBuilder: (context, index) {
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
                                        foods()[index]['name'],
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
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Minuman',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: foods().length,
                            itemBuilder: (context, index) {
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
                                        drinks()[index]['name'],
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
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
