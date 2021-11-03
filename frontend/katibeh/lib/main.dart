import 'package:flutter/material.dart';
import 'package:katibeh/Providers/top_free_apps.dart';
import 'package:katibeh/Screens/welcome.dart';
import 'package:provider/provider.dart';

import 'Providers/top_apps.dart';
import 'Providers/theme.dart';
import 'Screens/search.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => TopAppsProvider()),
      ChangeNotifierProvider(create: (_) => TopFreeAppsProvider()),
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
        initialRoute: Welcome.id,
        routes: {
          Welcome.id: (context) => Welcome(),
          Search.id: (context) => Search(),
        },
      );
    });
  }
}
