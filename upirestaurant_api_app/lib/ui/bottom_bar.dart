import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upirestaurant_api_app/common/style.dart';
import 'package:upirestaurant_api_app/provider/scheduling_provider.dart';
import 'package:upirestaurant_api_app/ui/restaurant_detail_page.dart';
import 'package:upirestaurant_api_app/ui/restaurant_favorite.dart';
import 'package:upirestaurant_api_app/ui/restaurant_list_page.dart';
import 'package:upirestaurant_api_app/ui/restaurant_search.dart';
import 'package:upirestaurant_api_app/ui/settings.dart';
import 'package:upirestaurant_api_app/utils/notification_helper.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);


  @override 
  _BottomBarState createState() => _BottomBarState();
}
class _BottomBarState extends State<BottomBar>{
  final NotificationHelper _notificationHelper = NotificationHelper();
  int currentIndex=0;
  final List<Widget> screens =[
    const RestaurantListPage(),
    const SearchPage(),
    const FavoritePage(),
    ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: const Setting(),
    ),
  ];
  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
        RestaurantDetailPage.routeName);
  }
  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
  @override 
  Widget build(BuildContext context){
    return Scaffold(
    body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: secondaryColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.white70,
        iconSize: 40,
        currentIndex: currentIndex,
        onTap: (index) => setState(()=>currentIndex = index),
        items: const [
            BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: secondaryColor,
             ),
             BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: secondaryColor,
             ),
             BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
            backgroundColor: secondaryColor,
             ),
             BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: secondaryColor,
             ),
        ])
  );
  }
}