import 'package:flutter/material.dart';
import 'package:katibeh/Providers/categories.dart';
import 'package:provider/provider.dart';

import '../Providers/theme.dart';
import 'drawer.dart';

class Categories extends StatelessWidget {
  static const id = 'Categories';

  Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CategoriesProvider>().fetchCategories;
    double w = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<CategoriesProvider>().fetchCategories;
        },
        child: Center(
          child: Consumer<CategoriesProvider>(
            builder: (context, value, child) {
              return value.categoriesMap.isEmpty && !value.categoriesError
                  ? CircularProgressIndicator()
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
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.grey[400]),
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
}
