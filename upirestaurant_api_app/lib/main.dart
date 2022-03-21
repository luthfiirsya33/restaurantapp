import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upirestaurant_api_app/api/api_service.dart';
import 'package:upirestaurant_api_app/common/navigation.dart';
import 'package:upirestaurant_api_app/common/style.dart';
import 'package:upirestaurant_api_app/data/db/database_helper.dart';
import 'package:upirestaurant_api_app/data/preferences/preferences_helper.dart';
import 'package:upirestaurant_api_app/provider/database_provider.dart';
import 'package:upirestaurant_api_app/provider/list_provider.dart';
import 'package:upirestaurant_api_app/provider/preferences_provider.dart';
import 'package:upirestaurant_api_app/provider/scheduling_provider.dart';
import 'package:upirestaurant_api_app/ui/splash_screen.dart';
import 'package:upirestaurant_api_app/utils/background_service.dart';
import 'package:upirestaurant_api_app/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    
Future <void> main() async{
   WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => ListRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
    ],
    child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
    return MaterialApp(
      title: 'UPI RestaurantApp',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
        color: secondaryColor,
        ),
      ),
      navigatorKey: navigatorKey,
      home: const SplashScreen(),
      );}
    ),
  );}
}