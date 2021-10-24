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
              body: ListView.builder(
                itemCount: 1,
                itemBuilder: (content, index) => GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 6,
                    color: Colors.amber,
                    margin: const EdgeInsets.all(3),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          // Column(
                          //   children: [
                          //     Padding(
                          //       padding:
                          //       const EdgeInsets.symmetric(
                          //           horizontal: 5),
                          //       child: const Icon(
                          //         Icons.alarm,
                          //         size: 28,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // Column(
                          //   crossAxisAlignment:
                          //   CrossAxisAlignment.start,
                          //   children: [
                          //     Row(
                          //       children: [
                          //         Text(
                          //           "به من",
                          //           style: const TextStyle(
                          //               fontFamily: 'IranSans'),
                          //         ),
                          //         SizedBox(width: 5),
                          //         Text(
                          //             alarmContent['others']
                          //             [index]
                          //             ['distance']
                          //                 .toString() +
                          //                 " کیلومتری",
                          //             style: const TextStyle(
                          //                 fontFamily:
                          //                 'IranSans')),
                          //       ],
                          //     ),
                          //     SizedBox(height: 10),
                          //     Row(
                          //       children: [
                          //         Directionality(
                          //           textDirection:
                          //           TextDirection.rtl,
                          //           child: Text(
                          //             alarmContent['others'][
                          //             index]
                          //             ['status']
                          //                 .toString() ==
                          //                 "1"
                          //                 ? "به مقصد رسیده"
                          //                 : "به مقصد نرسیده",
                          //             style: TextStyle(
                          //                 fontFamily:
                          //                 'IranSans',
                          //                 color: alarmContent['others']
                          //                 [
                          //                 index]
                          //                 [
                          //                 'status']
                          //                     .toString() ==
                          //                     "1"
                          //                     ? Colors.teal
                          //                     : Colors.red),
                          //             textAlign:
                          //             TextAlign.start,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(height: 10),
                          //     Row(
                          //       children: [
                          //         Directionality(
                          //           textDirection:
                          //           TextDirection.ltr,
                          //           child: Text(
                          //             Utils.calcTime(
                          //                 alarmContent['others']
                          //                 [index]
                          //                 ['updated_at']),
                          //             style: const TextStyle(
                          //                 fontFamily:
                          //                 'IranSans'),
                          //           ),
                          //         ),
                          //       ],
                          //     )
                          //   ],
                          // ),
                          // Row(
                          //   crossAxisAlignment:
                          //   CrossAxisAlignment.end,
                          //   children: [
                          //     Container(
                          //       width: w,
                          //       child: Text(
                          //         alarmContent['others'][index]
                          //         ['city_name'],
                          //         overflow: TextOverflow.clip,
                          //         style: const TextStyle(
                          //             fontFamily: 'IranSans',
                          //             color: Colors.deepPurple),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // Column(
                          //   children: [
                          //     Switch(
                          //       value: alarmContent['others']
                          //       [index]
                          //       ['active']
                          //           .toString() ==
                          //           'false'
                          //           ? false
                          //           : (alarmContent['others']
                          //       [index]
                          //       ['active']
                          //           .toString() ==
                          //           '0'
                          //           ? false
                          //           : true),
                          //       onChanged: (val) async =>
                          //       await onChangedSwitch(
                          //           alarmContent['others']
                          //           [index],
                          //           val),
                          //     ),
                          //   ],
                          // )
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
