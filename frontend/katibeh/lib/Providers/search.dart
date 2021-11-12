import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:katibeh/Models/app.dart';

import '../constants.dart';

class SearchProvider with ChangeNotifier {
  List<App> _searchedApps = [];
  bool _error = false;
  String _errorMessage = "";
  bool _loading = false;

  bool get loading => _loading;

  List<App> get searchedApps => _searchedApps;

  bool get searchedAppsError => _error;

  String get searchedAppsErrorMessage => _errorMessage;

  Future<void> fetchSearchedApps({int page = 1, String searchItem = ""}) async {
    if (searchItem != "") {
      try {
        _loading = true;
        notifyListeners();
        final response = await http
            .get(Uri.parse(domain + "/search/$searchItem?page=$page&limit=$limit"))
            .catchError((e) {
          print(e.toString());
          _error = true;
          _errorMessage = e.toString();
          _searchedApps = [];
          _loading = false;
          notifyListeners();
        });

        if (response.statusCode == 200) {
          (jsonDecode(response.body)['data']['items'] as List)
              .map((e) => _searchedApps.add(App.fromJson(e)))
              .toList();
          _error = false;
          _loading = false;
        } else {
          _error = true;
          _errorMessage = "Something bad happened";
          _searchedApps = [];
          _loading = false;
        }
        notifyListeners();
      } catch (e) {
        print(e.toString());
        _error = true;
        _errorMessage = e.toString();
        _searchedApps = [];
        _loading = false;
        notifyListeners();
      }
    }
  }

  void initialValues() {
    _searchedApps = [];
    _error = false;
    _errorMessage = "";
    _loading = false;
    notifyListeners();
  }
}
