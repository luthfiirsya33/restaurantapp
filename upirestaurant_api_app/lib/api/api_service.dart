import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:upirestaurant_api_app/data/model/detail.dart';
import 'package:upirestaurant_api_app/data/model/restaurant.dart';
import 'package:upirestaurant_api_app/data/model/search.dart';
import 'package:http/http.dart' show Client;

class ApiService {
   Client? client;
   ApiService({this.client}){
     client ??= Client();
   }
  
  final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<Listrestaurant> listRestaurant() async {
    final response = await client!.get(Uri.parse(_baseUrl+'list'));
    if (response.statusCode == 200) {
      return Listrestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<Detailrestaurant> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + 'detail/$id'));
    if (response.statusCode == 200) {
      return Detailrestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<Searchrestaurant> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + 'search?q=$query'));
    if(response.statusCode == 200) {
      return Searchrestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search restaurant');
    }
  }
}