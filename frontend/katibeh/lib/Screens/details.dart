import 'package:flutter/material.dart';
import 'package:katibeh/Providers/details.dart';
import 'package:katibeh/Providers/theme.dart';
import 'package:katibeh/Screens/search.dart';
import 'package:katibeh/widgets/app_details.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  static const id = 'Details';
  final appId;

  Details(this.appId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AppDetailsProvider>().fetchAppDetails(appId);
    context.read<AppDetailsProvider>().fetchAppDetailsDesc(appId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
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
          await context.read<AppDetailsProvider>().fetchAppDetails(appId);
          await context.read<AppDetailsProvider>().fetchAppDetailsDesc(appId);
        },
        child: Center(
          child: Consumer<AppDetailsProvider>(
            builder: (context, value, child) {
              return value.map.isEmpty && !value.error
                  ? CircularProgressIndicator()
                  : value.map.isNotEmpty &&
                          !value.error &&
                          value.map['data'].length == 0
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
                      : value.error
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
                          : AppDetails(value.map, value.mapDesc);
            },
          ),
        ),
      ),
    );
  }
}
