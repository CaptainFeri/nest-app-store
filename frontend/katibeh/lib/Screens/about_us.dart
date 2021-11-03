import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/top_apps.dart';
import '../Providers/theme.dart';
import '../widgets/drawer.dart';

class AboutUs extends StatelessWidget {
  static const id = 'AboutUs';

  AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TopAppsProvider>().fetchTopApps;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
              elevation: 2,
              color: context.read<ThemeProvider>().cardColor,
              margin: const EdgeInsets.all(3),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[400]),
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
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 50,
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
