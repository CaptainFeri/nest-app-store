import 'package:flutter/material.dart';
import 'package:katibeh/Providers/categories.dart';
import 'package:katibeh/Screens/search.dart';
import 'package:provider/provider.dart';

import '../Providers/theme.dart';
import '../widgets/drawer.dart';
import 'category.dart';

class Categories extends StatelessWidget {
  static const id = 'Categories';

  Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CategoriesProvider>().fetchCategories();
    double w = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Categories'),
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
          await context.read<CategoriesProvider>().fetchCategories();
        },
        child: Center(
          child: Consumer<CategoriesProvider>(
            builder: (context, value, child) {
              return value.categoriesMap.isEmpty && !value.categoriesError
                  ? Stack(
                      children: [
                        ListView(),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    )
                  : value.categoriesMap.isNotEmpty &&
                          !value.categoriesError &&
                          value.categoriesMap['data'].length == 0
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
                      : value.categoriesError
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
                              itemCount: value.categoriesMap["data"][0].length,
                              itemBuilder: (content, index) => GestureDetector(
                                onTap: () => onTap(
                                    context,
                                    value.categoriesMap['data'][0][index]
                                        ['prime_genre']),
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
                                                  value.categoriesMap["data"][0]
                                                      [index]["prime_genre"],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            );
            },
          ),
        ),
      ),
    );
  }

  onTap(context, catName) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Category(catName)));
  }
}
