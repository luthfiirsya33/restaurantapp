import 'package:flutter/material.dart';
import 'package:upirestaurant_api_app/common/style.dart';
import 'package:upirestaurant_api_app/data/model/search.dart';
import 'package:upirestaurant_api_app/ui/restaurant_detail_page.dart';

class CardSearch extends StatelessWidget {
  final SearchRestaurant restaurant;

  // ignore: use_key_in_widget_constructors
  const CardSearch({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: Image.network(
            "https://restaurant-api.dicoding.dev/images/small/" + restaurant.pictureId,
            width: 100,
          ),
        ),
        title: Text(
          restaurant.name,
        ),
        subtitle: Text(restaurant.city),
        onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RestaurantDetailPage(id: restaurant.id))
        ),
      ),
    );
  }
}