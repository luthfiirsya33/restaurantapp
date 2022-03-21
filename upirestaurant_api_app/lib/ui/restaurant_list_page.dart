import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:upirestaurant_api_app/api/api_service.dart';
import 'package:upirestaurant_api_app/provider/list_provider.dart';
import 'package:upirestaurant_api_app/ui/restaurant_search.dart';
import 'package:upirestaurant_api_app/utils/result_state.dart';
import 'package:upirestaurant_api_app/widget/card_restaurant.dart';
import 'package:upirestaurant_api_app/widget/platform_widget.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  
  Widget _buildList(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ListRestaurantProvider(apiService: ApiService()),
    child: Consumer<ListRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result?.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result!.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:350, width:350, child:Lottie.asset("asset/networkerror.json")),
          ],
        ),
      ),
      
    );
        } else {
          return const Center(child: Text('No Search Data'));
        }
      },
    ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPage()));
                  },
                  icon: const Icon(Icons.search)),
            ),
        ],
        title: const Text('UPI RestaurantApp',
        textAlign: TextAlign.center,),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('UPI RestaurantApp'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

