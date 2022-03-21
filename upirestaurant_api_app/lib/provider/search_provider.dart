import 'package:flutter/foundation.dart';
import 'package:upirestaurant_api_app/api/api_service.dart';
import 'package:upirestaurant_api_app/data/model/search.dart';
import 'package:upirestaurant_api_app/utils/result_state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService}) {
    fetchSearchRestaurant(query);
  }

  Searchrestaurant? _searchRestaurant;
  String _message = '';
  String _query = '';
  ResultState? _state;

  String get message => _message;

  String get query => _query;

  Searchrestaurant? get result => _searchRestaurant;

  ResultState? get state => _state;

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      _query = query;
      notifyListeners();
      final restaurantSearch = await apiService.searchRestaurant(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No Data Found';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searchRestaurant = restaurantSearch;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
