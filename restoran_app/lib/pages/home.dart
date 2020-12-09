import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restoran_app/api/api_restaurant.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:restoran_app/pages/detail_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Restaurant>> getList() async {
    final response = await http.get(ApiService.list);
    final List<Restaurant> data = parseRestaurants(response.body);
    return data;
  }

  Future<List<Restaurant>> getListSearch() async {
    final response = await http.get(ApiService.search + _query);
    final List<Restaurant> data = parseRestaurants(response.body);
    return data;
  }

  Future<Null> handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(milliseconds: 500)).then((_) {
      completer.complete();
      setState(() {});
    });
    return completer.future;
  }

  bool _isSearch = false;
  String _query = '';
  var _tecSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Container(
          child: FutureBuilder<List>(
            future: _isSearch ? getListSearch() : getList(),
            builder: (context, snapshot) {
              var state = snapshot.connectionState;
              if (state != ConnectionState.done) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return RefreshIndicator(
                  onRefresh: handleRefresh,
                  child: snapshot.data.isEmpty
                      ? _noData()
                      : ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return _buildArticleItem(
                                context, snapshot.data[index]);
                          },
                        ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return Text('');
              }
            },
          ),
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: _isSearch ? Colors.blue[200] : Colors.blue,
      title: _isSearch
          ? TextField(
              controller: _tecSearch,
              onChanged: (v) {
                setState(() {
                  _query = v;
                });
              },
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Search. . .'),
            )
          : Text('Restaurant App'),
      actions: [
        IconButton(
            icon: _isSearch
                ? Icon(
                    Icons.close,
                    color: Colors.black38,
                  )
                : Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isSearch = !_isSearch;
                _tecSearch.text = '';
                _query = '';
              });
            }),
      ],
    );
  }

  Widget _buildArticleItem(BuildContext context, Restaurant restaurant) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: restaurant);
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      ApiService.smallImage + restaurant.pictureId,
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text(
                    restaurant.name,
                    style: GoogleFonts.mcLaren(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      SizedBox(width: 5),
                      Text(
                        restaurant.city,
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 5),
                      Text(
                        restaurant.rating.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _noData() {
    return Center(
      child: Text('Data Ttdak ditemukan '),
    );
  }
}
