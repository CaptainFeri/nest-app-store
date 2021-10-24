import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Utils/theme_model.dart';

class Welcome extends StatelessWidget {
  static const id = 'Welcome';

  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (context) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, model, _) {
          return MaterialApp(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: model.mode,
            home: Scaffold(
              appBar: AppBar(
                title: Text('Katibeh'),
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
