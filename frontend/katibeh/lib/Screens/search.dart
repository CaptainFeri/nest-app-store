import 'package:flutter/material.dart';
import 'package:katibeh/Utils/utils.dart';
import 'package:provider/provider.dart';

import '../Providers/top_apps.dart';
import '../Providers/theme.dart';

class Search extends StatelessWidget {
  static const id = 'Search';

  Search({Key? key}) : super(key: key);

  onChangeTextFormField(String value) {
    print(value);
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
                onChanged: (value) => onChangeTextFormField(value),
                autocorrect: false,
                autofocus: true,
                cursorColor: Colors.red,
                style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none),
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 17, color: Colors.white38),
                  hintText: 'Search app name',
                  suffixIcon: Icon(Icons.search),
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
      body: Center(
        child: Consumer<TopAppsProvider>(
          builder: (context, value, child) {
            return Text("hi");
            // return value.map.length == 0 && !value.error
            //     ? CircularProgressIndicator()
            //     : value.error
            //         ? Text(
            //             "Oops! something went wrong. ${value.errorMessage}",
            //             textAlign: TextAlign.center,
            //           )
            //         : ListView.builder(
            //             itemCount: value.map["data"].length,
            //             itemBuilder: (content, index) => GestureDetector(
            //               onTap: () {},
            //               child: Card(
            //                 elevation: 2,
            //                 color: context.read<ThemeProvider>().cardColor,
            //                 margin: const EdgeInsets.all(3),
            //                 child: Padding(
            //                   padding: const EdgeInsets.symmetric(
            //                       vertical: 10, horizontal: 10),
            //                   child: Row(
            //                     children: [
            //                       Column(
            //                         children: [
            //                           Container(
            //                             decoration: BoxDecoration(
            //                                 borderRadius:
            //                                     BorderRadius.circular(50),
            //                                 color: Colors.grey[400]),
            //                             width: 60,
            //                             height: 60,
            //                             child: Icon(
            //                               Icons.apps,
            //                               size: 40,
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                       SizedBox(
            //                         width: 20,
            //                       ),
            //                       Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           Container(
            //                             width: w * 0.7,
            //                             child: Text(
            //                               value.map["data"][index]
            //                                   ["track_name"],
            //                               overflow: TextOverflow.ellipsis,
            //                               softWrap: true,
            //                               style: TextStyle(
            //                                   fontSize: 17,
            //                                   fontWeight: FontWeight.bold),
            //                             ),
            //                           ),
            //                           SizedBox(height: 10),
            //                           Row(
            //                             children: [
            //                               // Directionality(
            //                               //   textDirection: TextDirection.rtl,
            //                               //   child:
            //                               Container(
            //                                   width: w / 3,
            //                                   child: Text(
            //                                     Utils.formatBytes(
            //                                         int.parse(value.map["data"]
            //                                             [index]["size_bytes"]),
            //                                         2),
            //                                     style: TextStyle(fontSize: 12),
            //                                     // textAlign: TextAlign.start,
            //                                     // ),
            //                                   )),
            //                               if (value.map["data"][index]
            //                                       ["price"] !=
            //                                   "0")
            //                                 Icon(
            //                                   Icons.paid,
            //                                   size: 20,
            //                                   color: Colors.indigoAccent,
            //                                 )
            //                             ],
            //                           )
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           );
          },
        ),
      ),
    );
  }
}
