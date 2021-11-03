import 'package:flutter/material.dart';
import 'package:katibeh/Screens/search.dart';
import 'package:katibeh/Utils/utils.dart';
import 'package:provider/provider.dart';

import '../Providers/top_apps.dart';
import '../Providers/theme.dart';
import '../widgets/drawer.dart';

class Home extends StatelessWidget {
  static const id = 'Home';

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TopAppsProvider>().fetchTopApps;
    double w = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Katibeh'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(Search.id),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: context.read<ThemeProvider>().color,
                    size: 30,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: GestureDetector(
              onTap: () => context.read<ThemeProvider>().toggleMode(),
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
                    context.read<ThemeProvider>().icon,
                    color: context.read<ThemeProvider>().color,
                    size: 30,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<TopAppsProvider>().fetchTopApps;
        },
        child: Center(
          child: Consumer<TopAppsProvider>(
            builder: (context, value, child) {
              return value.topMap.isEmpty && !value.topError
                  ? CircularProgressIndicator()
                  : value.topMap.isNotEmpty &&
                          !value.topError &&
                          value.topMap['data'].length == 0
                      ? Stack(
                          children: [
                            ListView(),
                            Center(
                              child: Text(
                                "We couldn't find any app",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        )
                      : value.topError
                          ? Stack(
                              children: [
                                ListView(),
                                Center(
                                  child: Text(
                                    "Oops! something went wrong.",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              itemCount: value.topMap["data"].length,
                              itemBuilder: (content, index) => GestureDetector(
                                onTap: () {},
                                child: Card(
                                  elevation: 2,
                                  color:
                                      context.read<ThemeProvider>().cardColor,
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
                                                  borderRadius:
                                                      BorderRadius.circular(50),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: w,
                                              child: Text(
                                                value.topMap["data"][index]
                                                    ["track_name"],
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                // Directionality(
                                                //   textDirection: TextDirection.rtl,
                                                //   child:
                                                Container(
                                                    width: w / 3,
                                                    child: Text(
                                                      Utils.formatBytes(
                                                          int.parse(value
                                                                      .topMap[
                                                                  "data"][index]
                                                              ["size_bytes"]),
                                                          2),
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                      // textAlign: TextAlign.start,
                                                      // ),
                                                    )),
                                                if (value.topMap["data"][index]
                                                        ["price"] !=
                                                    "0")
                                                  Icon(
                                                    Icons.paid,
                                                    size: 20,
                                                    color: Colors.indigoAccent,
                                                  )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
            },
          ),
        ),
      ),
    );
  }
}
