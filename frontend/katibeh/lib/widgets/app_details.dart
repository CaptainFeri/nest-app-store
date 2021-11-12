import 'package:flutter/material.dart';
import 'package:katibeh/Providers/theme.dart';
import 'package:katibeh/Utils/utils.dart';
import 'package:provider/provider.dart';

class AppDetails extends StatelessWidget {
  final Map<String, dynamic> map;
  final Map<String, dynamic> mapDesc;

  AppDetails(this.map, this.mapDesc);

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
                                  map['data']['track_name'],
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: [
                                  if (map['data']['price'] != "0")
                                    Icon(
                                      Icons.paid,
                                      size: 20,
                                      color: Colors.indigoAccent,
                                    ),
                                  if (map['data']['price'] == "0")
                                    Icon(
                                      Icons.money_off,
                                      size: 20,
                                      color: Colors.green,
                                    ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  if (map['data']['price'] != "0")
                                    Text(
                                        map['data']['price'] +
                                            " " +
                                            map['data']['currency'],
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  if (map['data']['price'] == "0")
                                    Text("Free",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  if (map['data']['vpp_lic'].toString() == "1")
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
                                  map['data']['rating_count_tot'] + " Users",
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
                                      int.parse(map['data']['size_bytes']), 2),
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
                                  map['data']['cont_rating'],
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
                                  map['data']['ver'],
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
                                  map['data']['prime_genre'],
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
                                  map['data']['langnum'],
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
                            fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: w,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        mapDesc['data'][0]['app_desc'],
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 100,
                        style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.start,
                      ),
                    ),

                  ],
                ),
              )),
        ),
      ),
    );
  }
}
