import 'package:flutter/material.dart';
import 'package:katibeh/Providers/categories.dart';
import 'package:katibeh/Providers/details.dart';
import 'package:katibeh/Providers/top_free_apps.dart';
import 'package:katibeh/Screens/categories.dart';
import 'package:katibeh/Screens/home.dart';
import 'package:katibeh/Screens/top_apps.dart';
import 'package:katibeh/Screens/top_apps.dart';
import 'package:provider/provider.dart';

import 'Providers/top_apps.dart';
import 'Providers/theme.dart';
import 'Screens/about_us.dart';
import 'Screens/details.dart';
import 'Screens/search.dart';
import 'Screens/top_free_apps.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => TopAppsProvider()),
      ChangeNotifierProvider(create: (_) => TopFreeAppsProvider()),
      ChangeNotifierProvider(create: (_) => CategoriesProvider()),
      ChangeNotifierProvider(create: (_) => AppDetailsProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, model, _) {
      return MaterialApp(
        theme: ThemeData(
          // fontFamily: "IranSans",
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        darkTheme: ThemeData(
          // fontFamily: "IranSans",
          // primarySwatch: colorCustom,
          appBarTheme: AppBarTheme(backgroundColor: Colors.grey[850]),
          scaffoldBackgroundColor: Colors.grey[900],
          brightness: Brightness.dark,
        ),
        themeMode: model.mode,
        title: 'Katibeh',
        initialRoute: Home.id,
        routes: {
          Home.id: (context) => Home(),
          Search.id: (context) => Search(),
          Categories.id: (context) => Categories(),
          TopApps.id: (context) => TopApps(),
          TopFreeApps.id: (context) => TopFreeApps(),
          AboutUs.id: (context) => AboutUs(),
        },
      );
    });
  }
}
