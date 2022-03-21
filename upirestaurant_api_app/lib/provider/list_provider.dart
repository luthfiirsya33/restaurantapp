import 'package:flutter/foundation.dart';
import 'package:upirestaurant_api_app/api/api_service.dart';
import 'package:upirestaurant_api_app/data/model/restaurant.dart';
import 'package:upirestaurant_api_app/utils/result_state.dart';

class ListRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ListRestaurantProvider({required this.apiService}) {
    fetchListRestaurant();
  }

  Listrestaurant? _listRestaurant;
  String _message = '';
  ResultState? _state;

  String get message => _message;

  Listrestaurant? get result => _listRestaurant;

  ResultState? get state => _state;

  Future<dynamic> fetchListRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantList = await apiService.listRestaurant();
      if (restaurantList.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No Data Found';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _listRestaurant = restaurantList;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
