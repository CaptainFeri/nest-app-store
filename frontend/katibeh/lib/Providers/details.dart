import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:katibeh/constants.dart';

class AppDetailsProvider with ChangeNotifier {
  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errorMessage = "";

  Map<String, dynamic> _mapDesc = {};
  bool _errorDesc = false;
  String _errorMessageDesc = "";

  Map<String, dynamic> get map => _map;

  bool get topError => _error;

  String get topErrorMessage => _errorMessage;

  Map<String, dynamic> get mapDesc => _mapDesc;

  bool get topErrorDesc => _errorDesc;

  String get topErrorMessageDesc => _errorMessageDesc;

  Future<void> fetchAppDetails(int i) async {
    try {
      final response = await http
          .get(Uri.parse(domain+"/"+i.toString()))
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

  Future<void> fetchAppDetailsDesc(int i) async {
    try {
      final response = await http
          .get(Uri.parse(domain+"/info/"+i.toString()))
          .catchError((e) {
        print(e.toString());
        _errorDesc = true;
        _errorMessageDesc = e.toString();
        _mapDesc = {};
        notifyListeners();
      });

      if (response.statusCode == 200) {
        try {
          _mapDesc = jsonDecode(response.body);
          _errorDesc = false;
        } catch (e) {
          _errorDesc = true;
          _errorMessageDesc = e.toString();
          _mapDesc = {};
        }
      } else {
        _errorDesc = true;
        _errorMessageDesc = "It must be a problem with your internet connection.";
        _mapDesc = {};
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      _errorDesc = true;
      _errorMessageDesc = e.toString();
      _mapDesc = {};
      notifyListeners();
    }
  }

  void initialValues() {
    _map = {};
    _error = false;
    _errorMessage = "";
    _mapDesc = {};
    _errorDesc = false;
    _errorMessageDesc = "";
    notifyListeners();
  }
}
