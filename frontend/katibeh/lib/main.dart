import 'package:flutter/material.dart';
import 'package:katibeh/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katibeh',
      initialRoute: Welcome.id,
      routes: {
        Welcome.id: (context) => Welcome(),
      },
    );
  }
}
