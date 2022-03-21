import 'package:flutter/material.dart';
import 'package:upirestaurant_api_app/common/style.dart';
import 'package:upirestaurant_api_app/ui/bottom_bar.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);


  @override
  _SplashScreen createState() => _SplashScreen();

}
class _SplashScreen extends State<SplashScreen>{
  
  @override
  void initState(){
    super.initState();
    splashscreenStart();
  }
  splashscreenStart() async{
    var duration = const Duration(seconds: 3);
    return Timer(duration, () =>
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => BottomBar())),
    );
  }
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Icon(
              Icons.restaurant_menu,
              size: 100.0,
              color: Colors.white,
            ),
            SizedBox(height: 24.0,),
            Text("UPI RestaurantApp",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}