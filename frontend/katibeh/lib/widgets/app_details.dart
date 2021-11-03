import 'package:flutter/material.dart';

class AppDetails extends StatelessWidget {
  final Map<String, dynamic> map;

  AppDetails(this.map);

  @override
  Widget build(BuildContext context) {
    return Text(map['data']['track_name']);
  }
}
