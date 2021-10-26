import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Utils/theme_model.dart';

class Welcome extends StatelessWidget {
  static const id = 'Welcome';

  Welcome({Key? key}) : super(key: key);

  // static final Map<int, Color> color = {
  //   50: Color.fromRGBO(136, 14, 79, .1),
  //   100: Color.fromRGBO(136, 14, 79, .2),
  //   200: Color.fromRGBO(136, 14, 79, .3),
  //   300: Color.fromRGBO(136, 14, 79, .4),
  //   400: Color.fromRGBO(136, 14, 79, .5),
  //   500: Color.fromRGBO(136, 14, 79, .6),
  //   600: Color.fromRGBO(136, 14, 79, .7),
  //   700: Color.fromRGBO(136, 14, 79, .8),
  //   800: Color.fromRGBO(136, 14, 79, .9),
  //   900: Color.fromRGBO(136, 14, 79, 1),
  // };
  // static MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (context) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, model, _) {
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
            home: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Katibeh',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: GestureDetector(
                      onTap: () => model.toggleMode(),
                      child: Row(
                        children: [
                          // Text(
                          //   model.name,
                          //   style: TextStyle(
                          //       fontSize: 15,
                          //       color: model.color),
                          //   textDirection: TextDirection.rtl,
                          //   ),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          Icon(
                            model.icon,
                            color: model.color,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: 1,
                itemBuilder: (content, index) => GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 2,
                    color: model.cardColor,
                    margin: const EdgeInsets.all(3),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.grey[400]),
                                width: 60,
                                height: 60,
                                child: Icon(
                                  Icons.apps,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Telegram",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  // Directionality(
                                  //   textDirection: TextDirection.rtl,
                                  //   child:
                                  Text(
                                    "15 MB", style: TextStyle(fontSize: 12),
                                    // textAlign: TextAlign.start,
                                    // ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
