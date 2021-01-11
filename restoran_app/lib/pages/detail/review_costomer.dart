import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/models/detail_restaurant.dart';
import 'package:restoran_app/provider/detail_provider.dart';

class ReviewCustomer extends StatelessWidget {
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
                'Reviewer',
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
                itemCount: state.result.restaurant.customerReviews.length,
                itemBuilder: (context, index) {
                  return _itemReview(
                      context, state.result.restaurant.customerReviews[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card _itemReview(BuildContext context, CustomerReview data) {
    return Card(
      color: Colors.blue[100],
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  data.name,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  data.review,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
