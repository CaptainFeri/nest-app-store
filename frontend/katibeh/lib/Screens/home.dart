import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katibeh/Providers/categories.dart';
import 'package:katibeh/Providers/top_free_apps.dart';
import 'package:katibeh/Screens/categories.dart';
import 'package:katibeh/Screens/search.dart';
import 'package:katibeh/Screens/top_apps.dart';
import 'package:katibeh/Screens/top_free_apps.dart';
import 'package:katibeh/Utils/utils.dart';
import 'package:provider/provider.dart';

import '../Providers/top_apps.dart';
import '../Providers/theme.dart';
import 'category.dart';
import 'details.dart';
import '../widgets/drawer.dart';

class Home extends StatefulWidget {
  static const id = 'Home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => reset());
  }

  reset() async {
    context.read<TopAppsProvider>().initialValues();
    context.read<TopFreeAppsProvider>().initialValues();
    context.read<CategoriesProvider>().initialValues();
    await context.read<TopAppsProvider>().fetchTopApps();
    await context.read<TopFreeAppsProvider>().fetchTopFreeApps();
    await context.read<CategoriesProvider>().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
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
        onRefresh: () async => reset(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Text(
                    "Top Apps",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(TopApps.id),
                ),
                SizedBox(height: 10),
                Consumer<TopAppsProvider>(
                  builder: (context, value, child) {
                    return value.topApps.isEmpty && !value.topError
                        ? Stack(
                            children: [
                              ListView(shrinkWrap: true),
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          )
                        : value.topApps.isNotEmpty &&
                                !value.topError &&
                                value.topApps.length == 0
                            ? Stack(
                                children: [
                                  ListView(shrinkWrap: true),
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
                                      ListView(shrinkWrap: true),
                                      Center(
                                        child: Text(
                                          "Oops! something went wrong.",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    height: 250,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: value.topApps.length,
                                      itemBuilder: (content, index) =>
                                          GestureDetector(
                                        onTap: () => onTap(
                                            context, value.topApps[index]),
                                        child: Card(
                                          elevation: 2,
                                          color: context
                                              .read<ThemeProvider>()
                                              .cardColor,
                                          margin: const EdgeInsets.all(3),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: Colors.blue[300]),
                                                  width: 60,
                                                  height: 60,
                                                  child: Icon(
                                                    Icons.apps,
                                                    size: 40,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  width: w * 0.3,
                                                  child: Text(
                                                    value.topApps[index]
                                                        .trackName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    maxLines: 3,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(height: 5),
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
                                                                  .topApps[
                                                                      index]
                                                                  .sizeBytes),
                                                              2),
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                          // textAlign: TextAlign.start,
                                                          // ),
                                                        )),
                                                    if (value.topApps[index]
                                                            .price !=
                                                        "0")
                                                      Icon(
                                                        Icons.paid,
                                                        size: 20,
                                                        color:
                                                            Colors.indigoAccent,
                                                      ),
                                                    if (value.topApps[index]
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
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                  },
                ),
                SizedBox(height: 30),
                GestureDetector(
                  child: Text(
                    "Top Free Apps",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(TopFreeApps.id),
                ),
                SizedBox(height: 10),
                Consumer<TopFreeAppsProvider>(
                  builder: (context, value, child) {
                    return value.topFreeApps.isEmpty && !value.topError
                        ? Stack(
                            children: [
                              ListView(shrinkWrap: true),
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
                                  ListView(shrinkWrap: true),
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
                                      ListView(shrinkWrap: true),
                                      Center(
                                        child: Text(
                                          "Oops! something went wrong.",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    height: 250,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
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
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color:
                                                          Colors.greenAccent),
                                                  width: 60,
                                                  height: 60,
                                                  child: Icon(
                                                    Icons.apps,
                                                    size: 40,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  width: w * 0.3,
                                                  child: Text(
                                                    value.topFreeApps[index]
                                                        .trackName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    maxLines: 3,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(height: 5),
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
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                  },
                ),
                SizedBox(height: 30),
                GestureDetector(
                  child: Text(
                    "Categories",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(Categories.id),
                ),
                SizedBox(height: 10),
                Consumer<CategoriesProvider>(
                  builder: (context, value, child) {
                    return value.categoriesMap.isEmpty && !value.categoriesError
                        ? Stack(
                            children: [
                              ListView(shrinkWrap: true),
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          )
                        : value.categoriesMap.isNotEmpty &&
                                !value.categoriesError &&
                                value.categoriesMap.length == 0
                            ? Stack(
                                children: [
                                  ListView(shrinkWrap: true),
                                  Center(
                                    child: Text(
                                      "We couldn't find any app",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              )
                            : value.categoriesError
                                ? Stack(
                                    children: [
                                      ListView(shrinkWrap: true),
                                      Center(
                                        child: Text(
                                          "Oops! something went wrong.",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    height: 150,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          value.categoriesMap["data"][0].length,
                                      itemBuilder: (content, index) =>
                                          GestureDetector(
                                        onTap: () => onTapCat(
                                            context,
                                            value.categoriesMap['data'][0]
                                                [index]['prime_genre']),
                                        child: Card(
                                          elevation: 2,
                                          color: context
                                              .read<ThemeProvider>()
                                              .cardColor,
                                          margin: const EdgeInsets.all(3),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: Colors.pink[300]),
                                                  width: 60,
                                                  height: 60,
                                                  child: Icon(
                                                    Icons.category,
                                                    size: 40,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  width: w * 0.3,
                                                  child: Text(
                                                    value.categoriesMap["data"]
                                                            [0][index]
                                                        ["prime_genre"],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    maxLines: 3,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTap(context, topApp) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Details(topApp.id)));
  }

  onTapCat(context, catName) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Category(catName)));
  }
}
