import 'package:flutter/material.dart';
import 'package:katibeh/Providers/top_free_apps.dart';
import 'package:katibeh/Utils/utils.dart';
import 'package:provider/provider.dart';

import '../Providers/theme.dart';
import 'drawer.dart';

class TopFreeApps extends StatelessWidget {
  static const id = 'TopFreeApps';

  TopFreeApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TopFreeAppsProvider>().fetchTopFreeApps;
    double w = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Top Free Apps'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<TopFreeAppsProvider>().fetchTopFreeApps;
        },
        child: Center(
          child: Consumer<TopFreeAppsProvider>(
            builder: (context, value, child) {
              return value.topFreeMap.isEmpty && !value.topFreeError
                  ? CircularProgressIndicator()
                  : value.topFreeMap.isNotEmpty &&
                          !value.topFreeError &&
                          value.topFreeMap['data'].length == 0
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
                      : value.topFreeError
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
                              itemCount: value.topFreeMap["data"].length,
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
                                                value.topFreeMap["data"][index]
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
                                                                      .topFreeMap[
                                                                  "data"][index]
                                                              ["size_bytes"]),
                                                          2),
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                      // textAlign: TextAlign.start,
                                                      // ),
                                                    )),
                                                if (value.topFreeMap["data"][index]
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
