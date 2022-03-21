import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upirestaurant_api_app/common/style.dart';
import 'package:upirestaurant_api_app/data/model/restaurant.dart';
import 'package:upirestaurant_api_app/provider/database_provider.dart';
import 'package:upirestaurant_api_app/ui/restaurant_detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  // ignore: use_key_in_widget_constructors
  const CardRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(restaurant.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.getSmallPicture(),
          child: Image.network(
            restaurant.getSmallPicture(),
            width: 100,
          ),
        ),
        title: Text(
          restaurant.name,
        ),
        subtitle: Text(restaurant.city),
        trailing: isBookmarked
                    ? IconButton(
                        icon: Icon(Icons.favorite),
                        color: favoriteColor,
                        onPressed: () => provider.removeBookmark(restaurant.id),
                      )
                    : IconButton(
                        icon: Icon(Icons.favorite_border),
                        color: favoriteColor,
                        onPressed: () => provider.addBookmark(restaurant),
                      ),
        onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RestaurantDetailPage(id: restaurant.id))
                ),
              ),
            );
          },
        );
      },
    );
  }
}

