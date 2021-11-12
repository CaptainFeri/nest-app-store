import 'package:flutter/material.dart';
import 'package:katibeh/Screens/search.dart';
import 'package:provider/provider.dart';

import '../Providers/theme.dart';
import '../widgets/drawer.dart';

class AboutUs extends StatelessWidget {
  static const id = 'AboutUs';

  AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('About Us'),
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
      body: Center(
        child: SingleChildScrollView(
          child: Card(
              elevation: 2,
              color: context.read<ThemeProvider>().cardColor,
              margin: const EdgeInsets.all(3),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.redAccent[400]),
                      width: 60,
                      height: 60,
                      child: Icon(
                        Icons.build,
                        size: 40,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: w,
                      child: Text(
                        "Developers:",
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(color: Colors.purpleAccent[400],
                            fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: w,
                      child: Text(
                        "Koorosh Karkehabadi",
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: w,
                      child: Text(
                        "Mohammad Hossein Hossein Poor",
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: w,
                      child: Text(
                        "Zeynab Minaee",
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
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
