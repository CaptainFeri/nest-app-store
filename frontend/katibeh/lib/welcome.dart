import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Utils/theme_model.dart';

class Welcome extends StatelessWidget {
  static const id = 'Welcome';

  Welcome({Key? key}) : super(key: key);

  static final Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };
  static MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (context) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, model, _) {
          return MaterialApp(
            // theme: ThemeData.light(),
            theme: ThemeData(
              primarySwatch: colorCustom,
              accentColor: Colors.amber,
              backgroundColor: Colors.blue,
            ),
            darkTheme: ThemeData.dark(),
            themeMode: model.mode,
            home: Scaffold(
              appBar: AppBar(
                title: Text(
                  'کتیبه',
                  style: TextStyle(
                    fontFamily: 'IranSans',
                    fontSize: 20,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () => model.toggleMode(),
                      child: Row(
                        children: [
                          // Text(
                          //   model.name,
                          //   style: TextStyle(
                          //       fontFamily: 'IranSans',
                          //       fontSize: 15,
                          //       color: model.color),
                          //   textDirection: TextDirection.rtl,
                          //   ),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          Icon(model.icon, color: model.color)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
