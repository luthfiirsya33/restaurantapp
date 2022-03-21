import 'package:flutter/material.dart';
import 'package:upirestaurant_api_app/common/style.dart';
import 'package:upirestaurant_api_app/data/model/detail.dart';
import 'package:upirestaurant_api_app/ui/restaurant_review.dart';

class CustomDetail extends StatelessWidget {
 
  final Restaurant restaurant;
  // ignore: use_key_in_widget_constructors
  const CustomDetail({required this.restaurant});
 
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(restaurant.name),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
              tag: restaurant.pictureId,
              child: Image.network("https://restaurant-api.dicoding.dev/images/medium/" + restaurant.pictureId)),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                    child: Text(
                      restaurant.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24, 
                      ),
                    ),),
                    const Divider(color: Colors.grey),
                    Row(children: [
                    Icon(Icons.star,
                    color: Colors.yellow[700],),
                    Text('${restaurant.rating}')],),
                    const SizedBox(height: 10),
                    Row(children: [
                    Icon(Icons.location_on,
                    color: secondaryColor,),
                    Text('${restaurant.address}'', ''${restaurant.city}'),
                    ],),
                    const Divider(color: Colors.grey),
                    Text(restaurant.description),
                    const Divider(color: Colors.grey),
                    const Center(
                    child: Text(
                      '- Menu -',
                      style: TextStyle(fontSize: 20),
                    ),
                    ),
                    const Divider(color: Colors.grey),
                    const Text(
                      'Food',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Divider(color: Colors.grey),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children:restaurant.menus.foods.map((food) => Text(' ${food.name}.')).toList(),
                        ),
                    ),
                    const Divider(color: Colors.grey),
                    const Text(
                      'Drink',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Divider(color: Colors.grey),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children:restaurant.menus.drinks.map((drink) => Text(' ${drink.name}.')).toList(),
                        ),
                    ),
                    const Divider(color: Colors.grey),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF388E3C),
                          Color(0xFF66BB6A),
                          Color(0xFFA5D6A7),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RestaurantReview(restaurant: restaurant,))),
                  child: const Text('Reviews'),
                ),
                  ],
                ),
              ),]
              ),
            ],
          ),
        ),
      ])));
    }
  }