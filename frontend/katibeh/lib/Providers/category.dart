import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:katibeh/Models/app.dart';

import '../constants.dart';

class CategoryProvider with ChangeNotifier {
  List<App> _category = [];
  bool _error = false;
  String _errorMessage = "";
  bool _loading = false;

  bool get loading => _loading;

  List<App> get category => _category;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  Future<void> fetchCategory({int page = 1, String cat = 'Shopping'}) async {
    try {
      _loading = true;
      notifyListeners();
      final response = await http
          .get(Uri.parse(domain + "/category/$cat?page=$page&limit=$limit"))
          .catchError((e) {
        print(e.toString());
        _error = true;
        _errorMessage = e.toString();
        _category = [];
        _loading = false;
        notifyListeners();
      });

      if (response.statusCode == 200) {
        (jsonDecode(response.body)['data']['items'] as List)
            .map((e) => _category.add(App.fromJson(e)))
            .toList();
        _error = false;
        _loading = false;
      } else {
        _error = true;
        _errorMessage = "Something bad happened";
        _category = [];
        _loading = false;
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      _error = true;
      _errorMessage = e.toString();
      _category = [];
      _loading = false;
      notifyListeners();
    }
  }

  void initialValues() {
    _category = [];
    _error = false;
    _errorMessage = "";
    _loading = false;
    notifyListeners();
  }
}
