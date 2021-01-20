import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/provider/profile_provider.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileProvider>(
      create: (_) => ProfileProvider(),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, isScroll) {
            return [
              _buildSliverAppBar(context),
            ];
          },
          body: Consumer<ProfileProvider>(builder: (context, state, _) {
            return Card(
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text(
                      'Reminder',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: state.isRemind,
                    onChanged: (value) => state.onChangeRemind(value),
                  ),
                  ListTile(
                    title: Text(
                      'Show Notifikasi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // onTap: () =>
                    //     state.showNotification(flutterLocalNotificationsPlugin),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Profile'),
        background: Hero(
          tag: 'ikonapp',
          child: Center(
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/ikon.png',
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
