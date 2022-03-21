import 'dart:convert';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:upirestaurant_api_app/common/navigation.dart';
import 'package:upirestaurant_api_app/data/model/restaurant.dart';
import 'package:upirestaurant_api_app/ui/restaurant_detail_page.dart';

final selectNotificationSubject = BehaviorSubject<String>();
 
class NotificationHelper {
  static NotificationHelper? _instance;
 
  NotificationHelper._internal() {
    _instance = this;
  }
 
  factory NotificationHelper() => _instance ?? NotificationHelper._internal();
 
  Future<void> initNotifications(
     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
 
    var initializationSettingsIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
 
    var initializationSettings = InitializationSettings(
       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
 
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
       onSelectNotification: (String? payload) async {
      if (payload != null) {
        // ignore: avoid_print
        print('notification payload: ' + payload);
        var data = Restaurant.fromJson(json.decode(payload));
        await Navigation.intentWithData(RestaurantDetailPage.routeName, data);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }
 
  Future<void> showNotification(
     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
     Listrestaurant restaurants) async {
    var restaurant = restaurants.restaurants[Random().nextInt(restaurants.restaurants.length)];
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "upi restaurant channel"; 
 
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));
 
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
 
    var titleNotification = "<b>Upi Restaurant</b>";
    var titleRestaurant = "Don't miss it! voucher discount ${Random().nextInt(70)}% for food at " + restaurant.name + " in " + restaurant.city;
 
    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleRestaurant, platformChannelSpecifics,
        payload: json.encode(restaurant.toJson()));
  }
 
  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = Listrestaurant.fromJson(json.decode(payload));
        var article = data.restaurants[0];
        Navigation.intentWithData(route, article);
      },
    );
  }
}