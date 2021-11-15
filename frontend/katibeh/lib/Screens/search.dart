import 'package:flutter/material.dart';
import 'package:katibeh/Models/app.dart';
import 'package:katibeh/Providers/search.dart';

import 'package:katibeh/Utils/utils.dart';
import 'package:provider/provider.dart';

import '../Providers/theme.dart';
import 'details.dart';

class Search extends StatefulWidget {
  static const id = 'Search';

  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  ScrollController _scrollController = ScrollController();
  int page = 1;
  String val = "";
  List<App> searchedItems = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => reset());
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        context
            .read<SearchProvider>()
            .fetchSearchedApps(page: ++page, searchItem: val);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  reset() async {
    context.read<SearchProvider>().initialValues();
    page = 1;
    val = "";
  }

  Future<void> onChangeTextFormField(String value, BuildContext context) async {
    reset();
    val = value;

    if (value != "") {
      await context
          .read<SearchProvider>()
          .fetchSearchedApps(page: 1, searchItem: value);
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25, left: 0),
            child: Container(
              width: MediaQuery.of(context).orientation == Orientation.landscape
                  ? w * 0.85
                  : w * 0.76,
              child: TextFormField(
                onChanged: (value) => onChangeTextFormField(value, context),
                autocorrect: false,
                autofocus: true,
                cursorColor: Colors.red,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    decoration: TextDecoration.none),
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 17, color: Colors.white38),
                  hintText: 'Search app name',
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.white38,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 20, bottom: 20),
                ),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => onChangeTextFormField(val, context),
        child: Center(
          child: Consumer<SearchProvider>(
            builder: (context, value, child) {
              return value.searchedApps.isEmpty &&
                      !value.searchedAppsError &&
                      value.loading
                  ? Stack(
                      children: [
                        ListView(),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    )
                  : value.searchedApps.isEmpty &&
                          !value.searchedAppsError &&
                          !value.loading
                      ? Stack(
                          children: [
                            ListView(),
                            Center(
                              child: Text(
                                "Sorry! there is no app.",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        )
                      : value.searchedApps.isNotEmpty &&
                              !value.searchedAppsError &&
                              value.searchedApps.length == 0
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
                          : value.searchedAppsError
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
                                      itemCount: value.searchedApps.length,
                                      itemBuilder: (content, index) =>
                                          GestureDetector(
                                        onTap: () => onTap(
                                            context, value.searchedApps[index]),
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
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: Colors.teal),
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
                                                        value
                                                            .searchedApps[index]
                                                            .trackName,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: true,
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                                      .searchedApps[
                                                                          index]
                                                                      .sizeBytes),
                                                                  2),
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                              // textAlign: TextAlign.start,
                                                              // ),
                                                            )),
                                                        if (value
                                                                .searchedApps[
                                                                    index]
                                                                .price !=
                                                            "0")
                                                          Icon(
                                                            Icons.paid,
                                                            size: 20,
                                                            color: Colors
                                                                .indigoAccent,
                                                          ),
                                                        if (value
                                                                .searchedApps[
                                                                    index]
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
