import 'package:flutter/material.dart';
import 'package:katibeh/Utils/utils.dart';
import 'package:provider/provider.dart';

import '../Models/app.dart';
import '../Models/theme.dart';

class Search extends StatelessWidget {
  static const id = 'Search';

  Search({Key? key}) : super(key: key);

  onChangeTextFormField(String value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    context.read<App>().fetchData;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? w * 0.8
                        : w * 0.7,
                    child: TextFormField(
                      onChanged: (value) =>onChangeTextFormField(value),
                    ),
                  ),
                  Icon(
                    Icons.clear,
                    color: context.read<ThemeModel>().color,
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
          await context.read<App>().fetchData;
        },
        child: Center(
          child: Consumer<App>(
            builder: (context, value, child) {
              return value.map.length == 0 && !value.error
                  ? CircularProgressIndicator()
                  : value.error
                      ? Text(
                          "Oops! something went wrong. ${value.errorMessage}",
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          itemCount: value.map["data"].length,
                          itemBuilder: (content, index) => GestureDetector(
                            onTap: () {},
                            child: Card(
                              elevation: 2,
                              color: context.read<ThemeModel>().cardColor,
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
                                          width: w * 0.7,
                                          child: Text(
                                            value.map["data"][index]
                                                ["track_name"],
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
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
                                                      int.parse(
                                                          value.map["data"]
                                                                  [index]
                                                              ["size_bytes"]),
                                                      2),
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                  // textAlign: TextAlign.start,
                                                  // ),
                                                )),
                                            if (value.map["data"][index]
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
