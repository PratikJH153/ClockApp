import 'package:clockapp/models/menu_info.dart';
import 'package:clockapp/helpers/enums.dart';
import 'package:clockapp/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid =
      AndroidInitializationSettings("codex_logo");

  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
    if (payload != null) {
      debugPrint("notification payload: " + payload.payload!);
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: "ClockApp",
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF2D2F41),
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (ctx) => const Scaffold(
          body: Center(
            child: Text("404 Not Found"),
          ),
        ),
      ),
      home: ChangeNotifierProvider<MenuInfo>(
        create: (context) => MenuInfo(menuType: MenuType.clock),
        child: const HomePage(),
      ),
      // initialRoute: HomePage.routeID,
      routes: {
        HomePage.routeID: (context) => const HomePage(),
      },
    );
  }
}
