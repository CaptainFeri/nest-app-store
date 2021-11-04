import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class TopFreeAppsProvider with ChangeNotifier {
  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errorMessage = "";

  Map<String, dynamic> get topFreeMap => _map;

  bool get topFreeError => _error;

  String get topFreeErrorMessage => _errorMessage;

  Future<void> get fetchTopFreeApps async {
    try {
      final response = await http
          .get(Uri.parse(domain+"/top/free"))
          .catchError((e) {
        print(e.toString());
        _error = true;
        _errorMessage = e.toString();
        _map = {};
        notifyListeners();
      });

      if (response.statusCode == 200) {
        try {
          _map = jsonDecode(response.body);
          _error = false;
        } catch (e) {
          _error = true;
          _errorMessage = e.toString();
          _map = {};
        }
      } else {
        _error = true;
        _errorMessage = "It must be a problem with your internet connection.";
        _map = {};
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      _error = true;
      _errorMessage = e.toString();
      _map = {};
      notifyListeners();
    }
  }

  void initialValues() {
    _map = {};
    _error = false;
    _errorMessage = "";
    notifyListeners();
  }
}
