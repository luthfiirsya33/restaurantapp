import 'package:flutter/foundation.dart';
import 'package:upirestaurant_api_app/api/api_service.dart';
import 'package:upirestaurant_api_app/data/model/detail.dart';
import 'package:upirestaurant_api_app/utils/result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiServiceDetail;
  final String id;

  DetailRestaurantProvider({required this.apiServiceDetail, required this.id}) {
    fetchDetailRestaurant();
  }

  Detailrestaurant? _detailRestaurant;
  String _message = '';
  ResultState? _state;

  String get message => _message;

  Detailrestaurant? get result => _detailRestaurant;

  ResultState? get state => _state;

  Future<dynamic> fetchDetailRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantDetail = await apiServiceDetail.detailRestaurant(id);
      if (restaurantDetail.restaurant.id.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No Data Found';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailRestaurant = restaurantDetail;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
