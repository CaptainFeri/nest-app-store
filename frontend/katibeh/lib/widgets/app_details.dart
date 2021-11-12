import 'package:flutter/material.dart';
import 'package:katibeh/Providers/categories.dart';
import 'package:katibeh/Providers/category.dart';
import 'package:katibeh/Providers/theme.dart';
import 'package:katibeh/Providers/top_free_apps.dart';
import 'package:katibeh/Screens/details.dart';
import 'package:katibeh/Utils/utils.dart';
import 'package:provider/provider.dart';

class AppDetails extends StatefulWidget {
  final Map<String, dynamic> map;
  final Map<String, dynamic> mapDesc;

  AppDetails(this.map, this.mapDesc);

  @override
  State<AppDetails> createState() => _AppDetailsState();
}

class _AppDetailsState extends State<AppDetails> {
  String text = "More";

  int maxLine = 5;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Consumer<ThemeProvider>(
      builder: (context, value, child) => Align(
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          child: Card(
              elevation: 2,
              color: context.read<ThemeProvider>().cardColor,
              margin: const EdgeInsets.all(3),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.limeAccent[700]),
                            width: 80,
                            height: 80,
                            child: Icon(
                              Icons.apps,
                              size: 40,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: w / 2,
                                height: 100,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.map['data']['track_name'],
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: [
                                  if (widget.map['data']['price'] != "0")
                                    Icon(
                                      Icons.paid,
                                      size: 20,
                                      color: Colors.indigoAccent,
                                    ),
                                  if (widget.map['data']['price'] == "0")
                                    Icon(
                                      Icons.money_off,
                                      size: 20,
                                      color: Colors.green,
                                    ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  if (widget.map['data']['price'] != "0")
                                    Text(
                                        widget.map['data']['price'] +
                                            " " +
                                            widget.map['data']['currency'],
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  if (widget.map['data']['price'] == "0")
                                    Text("Free",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  if (widget.map['data']['vpp_lic']
                                          .toString() ==
                                      "1")
                                    Container(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Text("VPP",
                                          style: TextStyle(
                                              color: Colors.indigoAccent,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '3.4',
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 5),
                                    Icon(Icons.star, size: 20),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  widget.map['data']['rating_count_tot'] +
                                      " Users",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            VerticalDivider(
                                color: Colors.grey, width: 20, thickness: 1),
                            Column(
                              children: [
                                Icon(Icons.download, size: 22),
                                SizedBox(height: 5),
                                Text(
                                  Utils.formatBytes(
                                      int.parse(
                                          widget.map['data']['size_bytes']),
                                      2),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            VerticalDivider(
                                color: Colors.grey, width: 20, thickness: 1),
                            Column(
                              children: [
                                Icon(Icons.person, size: 22),
                                SizedBox(height: 5),
                                Text(
                                  widget.map['data']['cont_rating'],
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            VerticalDivider(
                                color: Colors.grey, width: 20, thickness: 1),
                            Column(
                              children: [
                                Icon(Icons.merge_type, size: 22),
                                SizedBox(height: 5),
                                Text(
                                  widget.map['data']['ver'],
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            VerticalDivider(
                                color: Colors.grey, width: 20, thickness: 1),
                            Column(
                              children: [
                                Icon(Icons.category_outlined, size: 22),
                                SizedBox(height: 5),
                                Text(
                                  widget.map['data']['prime_genre'],
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            VerticalDivider(
                                color: Colors.grey, width: 20, thickness: 1),
                            Column(
                              children: [
                                Icon(Icons.language, size: 22),
                                SizedBox(height: 5),
                                Text(
                                  widget.map['data']['langnum'],
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: w,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Description:",
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: w,
                      padding: EdgeInsets.all(10),
                      child: widget.mapDesc['data'] == null
                          ? Center(child: CircularProgressIndicator())
                          : Text(
                              widget.mapDesc['data'][0]['app_desc'],
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: maxLine,
                              style: TextStyle(
                                  fontSize: 15, fontStyle: FontStyle.italic),
                              textAlign: TextAlign.start,
                            ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            text == "More" ? text = "Less" : text = "More";
                            text == "More" ? maxLine = 5 : maxLine = 1000;
                          });
                        },
                        child: Text(text)),
                    SizedBox(
                        height: 50
                    ),
                    Text(
                      "You Might Also Like",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        height: 10
                    ),
                    Consumer<CategoryProvider>(
                      builder: (context, value, child) {
                        return value.category.isEmpty && !value.error
                            ? Stack(
                          children: [
                            ListView(shrinkWrap: true),
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        )
                            : value.category.isNotEmpty &&
                            !value.error &&
                            value.category.length == 0
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
                            : value.error
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
                            itemCount: value.category.length,
                            itemBuilder: (content, index) =>
                                GestureDetector(
                                  onTap: () => onTap(
                                      context, value.category[index]),
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
                                                color: Colors.greenAccent),
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
                                              value.category[index]
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
                                                            .category[
                                                        index]
                                                            .sizeBytes),
                                                        2),
                                                    style: TextStyle(
                                                        fontSize: 12),
                                                    // textAlign: TextAlign.start,
                                                    // ),
                                                  )),
                                              if (value.category[index]
                                                  .price !=
                                                  "0")
                                                Icon(
                                                  Icons.paid,
                                                  size: 20,
                                                  color:
                                                  Colors.indigoAccent,
                                                ),
                                              if (value.category[index]
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
                  ],
                ),
              )),
        ),
      ),
    );
  }
  onTap(context, topApp) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Details(topApp.id)));
  }
}

