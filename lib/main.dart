import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart';

import 'package:sezinsoft_demo/view/screens/home/view/home_screen.dart';
import 'package:sezinsoft_demo/view/screens/auth/login/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'core/locator.dart';
import 'core/managers/dialog_manager.dart';
import 'core/providers/general_provider.dart';
import 'core/services/dialog_service.dart';

class MyHttpoverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

SharedPreferences? prefs;
Future<void> main() async {
  HttpOverrides.global = MyHttpoverrides();
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GeneralProvider>.value(value: GeneralProvider()),
      ],
      builder: (context, _) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // home: WineDetailsScreen(id: 3038),
          home: const LoginScreen(),

          builder: (context, child) => Navigator(
            key: locator<DialogService>().dialogNavigationKey,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => DialogManager(child: child)),
          ),
          // routes: routes,
        );
      },
    );
  }
}
