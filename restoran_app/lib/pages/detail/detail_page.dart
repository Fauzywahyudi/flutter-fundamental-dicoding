import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/pages/detail/detail_restaurant_struktur.dart';
import 'package:restoran_app/pages/detail/my_sliver_appbar.dart';
import 'package:restoran_app/provider/detail_provider.dart';
import 'package:restoran_app/themes/text_themes.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_restaurant';
  final String id;
  const DetailPage({@required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
      create: (_) => DetailProvider(id: id),
      child: Scaffold(
        body: Consumer<DetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              return NestedScrollView(
                controller: state.controller,
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    MySliverAppBar(),
                  ];
                },
                body: ListDetailRestaurant(),
              );
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.NoConnection) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message, style: labelConnection),
                    SizedBox(height: 30),
                    RaisedButton(
                      onPressed: () => state.refresh(),
                      color: Colors.blue[200],
                      child: Text('Refresh'),
                    )
                  ],
                ),
              );
            } else {
              return Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
