import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class TopAppsProvider with ChangeNotifier {
  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errorMessage = "";

  Map<String, dynamic> get topMap => _map;

  bool get topError => _error;

  String get topErrorMessage => _errorMessage;

  Future<void> get fetchTopApps async {
    try {
      final response = await http
          .get(Uri.parse(domain+"/top"))
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
