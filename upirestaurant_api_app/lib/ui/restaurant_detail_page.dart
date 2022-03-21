import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:upirestaurant_api_app/api/api_service.dart';
import 'package:upirestaurant_api_app/provider/detail_provider.dart';
import 'package:upirestaurant_api_app/utils/result_state.dart';
import 'package:upirestaurant_api_app/widget/custom_detail.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
 
  final String id;
  // ignore: use_key_in_widget_constructors
  const RestaurantDetailPage({required this.id});

  Widget _buildDetail(){
    return ChangeNotifierProvider(
      create: (_) => DetailRestaurantProvider(apiServiceDetail: ApiService(), id: id),
    child: Consumer<DetailRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return CustomDetail(restaurant: state.result!.restaurant);
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
          return const Center(child: Text('No Detail data'));
        }
      },
    ),
    );

  }
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _buildDetail()));
    
  }
}



