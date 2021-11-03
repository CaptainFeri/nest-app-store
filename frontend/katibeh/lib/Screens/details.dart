import 'package:flutter/material.dart';
import 'package:katibeh/Providers/details.dart';
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
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<AppDetailsProvider>().fetchAppDetails(appId);
          await context.read<AppDetailsProvider>().fetchAppDetailsDesc(appId);
        },
        child: Center(
          child: Consumer<AppDetailsProvider>(
            builder: (context, value, child) {
              return value.map.isEmpty && !value.topError
                  ? CircularProgressIndicator()
                  : value.map.isNotEmpty &&
                          !value.topError &&
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
                      : value.topError
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
                          : AppDetails(value.map);
            },
          ),
        ),
      ),
    );
  }
}
