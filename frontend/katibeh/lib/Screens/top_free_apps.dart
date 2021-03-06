import 'package:flutter/material.dart';
import 'package:katibeh/Providers/top_free_apps.dart';
import 'package:katibeh/Screens/search.dart';
import 'package:katibeh/Utils/utils.dart';
import 'package:provider/provider.dart';

import '../Providers/theme.dart';
import 'details.dart';
import '../widgets/drawer.dart';

class TopFreeApps extends StatefulWidget {
  static const id = 'TopFreeApps';

  TopFreeApps({Key? key}) : super(key: key);

  @override
  State<TopFreeApps> createState() => _TopFreeAppsState();
}

class _TopFreeAppsState extends State<TopFreeApps> {
  ScrollController _scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => reset());
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        context.read<TopFreeAppsProvider>().fetchTopFreeApps(page: ++page);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  reset() async {
    context.read<TopFreeAppsProvider>().initialValues();
    page = 1;
    await context.read<TopFreeAppsProvider>().fetchTopFreeApps();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Top Free Apps'),
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
        onRefresh: () async => reset(),
        child: Center(
          child: Consumer<TopFreeAppsProvider>(
            builder: (context, value, child) {
              return value.topFreeApps.isEmpty && !value.topError
                  ? Stack(
                      children: [
                        ListView(),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    )
                  : value.topFreeApps.isNotEmpty &&
                          !value.topError &&
                          value.topFreeApps.length == 0
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
                          : Stack(
                              children: [
                                ListView.builder(
                                  controller: _scrollController,
                                  itemCount: value.topFreeApps.length,
                                  itemBuilder: (content, index) =>
                                      GestureDetector(
                                    onTap: () => onTap(
                                        context, value.topFreeApps[index]),
                                    child: Card(
                                      elevation: 2,
                                      color: context
                                          .read<ThemeProvider>()
                                          .cardColor,
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
                                                          BorderRadius.circular(
                                                              50),
                                                      color: Colors.greenAccent),
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
                                                  width: w * 0.6,
                                                  child: Text(
                                                    value.topFreeApps[index]
                                                        .trackName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                        width: w * 0.6 / 3,
                                                        child: Text(
                                                          Utils.formatBytes(
                                                              int.parse(value
                                                                  .topFreeApps[
                                                                      index]
                                                                  .sizeBytes),
                                                              2),
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                          // textAlign: TextAlign.start,
                                                          // ),
                                                        )),
                                                    if (value.topFreeApps[index]
                                                            .price !=
                                                        "0")
                                                      Icon(
                                                        Icons.paid,
                                                        size: 20,
                                                        color:
                                                            Colors.indigoAccent,
                                                      ),
                                                    if (value.topFreeApps[index]
                                                            .price ==
                                                        "0")
                                                      Icon(
                                                        Icons.money_off,
                                                        size: 20,
                                                        color: Colors.green,
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
                                ),
                                if (value.loading)
                                  Positioned(
                                    left: 0,
                                    bottom: 0,
                                    child: Container(
                                      height: 80,
                                      width: w,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                              ],
                            );
            },
          ),
        ),
      ),
    );
  }

  onTap(context, topApp) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Details(topApp.id)));
  }
}
