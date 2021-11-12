import 'package:flutter/material.dart';
import 'package:katibeh/Providers/category.dart';
import 'package:katibeh/Providers/details.dart';
import 'package:katibeh/Providers/theme.dart';
import 'package:katibeh/widgets/app_details.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  static const id = 'Details';
  final appId;

  Details(this.appId, {Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => reset());
  }

  reset() async {
    context.read<AppDetailsProvider>().initialValues();
    context.read<CategoryProvider>().initialValues();

    await context.read<AppDetailsProvider>().fetchAppDetails(widget.appId);
    Map<String, dynamic> map = context.read<AppDetailsProvider>().map;
    context.read<AppDetailsProvider>().fetchAppDetailsDesc(widget.appId);
    context.read<CategoryProvider>().fetchCategory(page: 1, cat: map['data']['prime_genre']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: [
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
        onRefresh: () async => reset(),
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
                                "We couldn't find any information.",
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
