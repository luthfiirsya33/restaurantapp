import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:upirestaurant_api_app/api/api_service.dart';
import 'package:upirestaurant_api_app/provider/search_provider.dart';
import 'package:upirestaurant_api_app/utils/result_state.dart';
import 'package:upirestaurant_api_app/widget/card_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String queries = '';
  final TextEditingController _controller = TextEditingController();

  Widget _buildSearch(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result?.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result!.restaurants[index];
              return CardSearch(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child:
          Container(
    alignment: Alignment.center,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
             SizedBox(height:350, width:350, child:Lottie.asset("asset/restaurantwait.json")),
           ],
        ),
      ), );
        } else {
          return const Center(child: Text('No List Data'));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
                        create: (_) => SearchRestaurantProvider(
                          apiService: ApiService(),
                        ),
                        child: Consumer<SearchRestaurantProvider>(
                          builder: (context, state, _) {
                            return Scaffold(
                              body: Stack(
                             children:[
                                SafeArea(
                                child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 16),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ), labelText: "search restaurant...",
                  ),
                  onChanged: (String value) {
                                        setState(() {
                                          queries = value;
                                        });
                                        state.fetchSearchRestaurant(value);
                                      },
                            )),
                            ),
                            const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: _buildSearch(context),
                        ),
                      ),
                  ]
                )
              );
            }
          )  
        );   
  }
}