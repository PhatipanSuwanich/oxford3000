import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'screens/home.dart';
import 'screens/learn.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // Hive.registerAdapter(OrderAdapter());
  // await Hive.openBox<Order>("HistoryOrder");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
        background: Container(color: Color(0xFFF5F5F5)),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.itimTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Home()),
        GetPage(name: '/learn', page: () => LearnPage()),
        // GetPage(name: '/pre-order', page: () => PreOrder()),
        // GetPage(name: '/web3', page: () => Web3()),
      ],
    );
  }
}
