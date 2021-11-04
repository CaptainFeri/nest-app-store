import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:katibeh/Models/app.dart';

import '../constants.dart';

class TopAppsProvider with ChangeNotifier {
  List<App> _topApps = [];
  bool _error = false;
  String _errorMessage = "";
  bool _loading = false;

  bool get loading => _loading;

  List<App> get topApps => _topApps;

  bool get topError => _error;

  String get topErrorMessage => _errorMessage;

  Future<void> fetchTopApps({int page = 1}) async {
    try {
      _loading = true;
      notifyListeners();
      final response = await http
          .get(Uri.parse(domain + "/top?page=$page&limit=$limit"))
          .catchError((e) {
        print(e.toString());
        _error = true;
        _errorMessage = e.toString();
        _topApps = [];
        _loading = false;
        notifyListeners();
      });

      if (response.statusCode == 200) {
        (jsonDecode(response.body)['data']['items'] as List)
            .map((e) => _topApps.add(App.fromJson(e)))
            .toList();
        _error = false;
        _loading = false;
      } else {
        _error = true;
        _errorMessage = "Something bad happened";
        _topApps = [];
        _loading = false;
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      _error = true;
      _errorMessage = e.toString();
      _topApps = [];
      _loading = false;
      notifyListeners();
    }
  }

  void initialValues() {
    _topApps = [];
    _error = false;
    _errorMessage = "";
    _loading = false;
    notifyListeners();
  }
}
