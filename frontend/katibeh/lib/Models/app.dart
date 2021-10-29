import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class App with ChangeNotifier {
  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errorMessage = "";

  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errorMessage => _errorMessage;

  Future<void> get fetchData async{
    final response = await http.get(Uri.parse("http://192.168.1.102:3000/application/top"));

    if (response.statusCode == 200){
      try{
        _map = jsonDecode(response.body);
        _error = false;
      }catch(e){
        _error = true;
        _errorMessage = e.toString();
        _map = {};
      }
    }else{
      _error = true;
      _errorMessage = "It must be a problem with your internet connection.";
      _map = {};
    }
    notifyListeners();
  }

  void initialValues(){
    _map = {};
    _error = false;
    _errorMessage = "";
    notifyListeners();
  }
}
