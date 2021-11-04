import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class CategoriesProvider with ChangeNotifier {
  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errorMessage = "";

  Map<String, dynamic> get categoriesMap => _map;

  bool get categoriesError => _error;

  String get categoriesErrorMessage => _errorMessage;

  Future<void> get fetchCategories async {
    try {
      final response = await http
          .get(Uri.parse(domain+"/categories"))
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
        _errorMessage = "Something bad happened";
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
