import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/provider/scheduling_provider.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, isScroll) {
              return [
                _buildSliverAppBar(context),
              ];
            },
            body: Card(
              child: Column(
                children: [
                  Material(
                    child: ListTile(
                      title: Text('Scheduling Restaurants'),
                      trailing: Consumer<SchedulingProvider>(
                        builder: (context, scheduled, _) {
                          return Switch.adaptive(
                            value: scheduled.isScheduled,
                            onChanged: (value) async {
                              if (Platform.isIOS) {
                                print('comming soon');
                              } else {
                                scheduled.scheduledNews(value);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )),
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
