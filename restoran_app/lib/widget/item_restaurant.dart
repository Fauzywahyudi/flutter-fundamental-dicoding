import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restoran_app/api/api_restaurant.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:restoran_app/pages/detail/detail_page.dart';

class ItemRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const ItemRestaurant({this.restaurant});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, DetailPage.routeName,
            arguments: restaurant.id),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    ApiService.smallImage + restaurant.pictureId,
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    restaurant.name,
                    style: GoogleFonts.mcLaren(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
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
                          fontWeight: FontWeight.bold,
                        ),
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
                        restaurant.rating.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
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
}
