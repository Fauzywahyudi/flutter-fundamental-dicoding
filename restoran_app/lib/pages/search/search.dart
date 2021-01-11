import 'package:flutter/material.dart';
import 'package:restoran_app/api/api_restaurant.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:restoran_app/widget/item_restaurant.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        color: Colors.blue,
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      color: Colors.blue,
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ApiService api = ApiService();
    if (query.length < 2) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
    return Container(
        child: FutureBuilder<List<Restaurant>>(
      future: api.getSearch(query),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error);
        } else if (snapshot.hasData) {
          return snapshot.data.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "Not Found Restaurant",
                        style: TextStyle(color: Colors.red[200]),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ItemRestaurant(restaurant: snapshot.data[index]);
                  },
                );
        } else {
          return Text('');
        }
      },
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ApiService api = ApiService();
    if (query.length < 2) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Text(
              "Search term must be longer than two letters.",
            ),
          ),
        ],
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List<Restaurant>>(
            future: api.getSearch(query),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error);
              } else if (snapshot.hasData) {
                return snapshot.data.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "Not Found Restaurant",
                              style: TextStyle(color: Colors.red[200]),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        height: snapshot.data.length * 50.0,
                        child: ListView.builder(
                          itemCount: snapshot.data.length > 5
                              ? 5
                              : snapshot.data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(snapshot.data[index].name),
                            );
                          },
                        ),
                      );
              } else {
                return Text('');
              }
            },
          )
        ],
      ),
    );
  }
}
