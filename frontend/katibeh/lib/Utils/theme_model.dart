import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel with ChangeNotifier {
  ThemeMode _mode;
  String _name;
  IconData _icon;
  Color _color;

  ThemeMode get mode => _mode;

  String get name => _name;

  IconData get icon => _icon;

  Color get color => _color;

  ThemeModel(
      {ThemeMode mode = ThemeMode.light,
      String name = "تم روشن",
      IconData icon = Icons.light_mode,
      Color color = Colors.white})
      : _mode = mode,
        _name = name,
        _icon = icon,
        _color = color {
    loadTheme().then((value) {
      bool isDarkMode = value;
      _mode = (isDarkMode ? ThemeMode.dark : ThemeMode.light);
      _name = (isDarkMode ? "تم روشن" : "تم تیره");
      _icon = (isDarkMode ? Icons.light_mode : Icons.dark_mode);
      _color = (isDarkMode ? Colors.yellow : Colors.white);
      notifyListeners();
    });
  }

  void toggleMode() {
    if (_mode == ThemeMode.light) {
      _mode = ThemeMode.dark;
      _name = "تم روشن";
      _icon = Icons.light_mode;
      _color = Colors.yellow;
      saveTheme(true);
    } else {
      _mode = ThemeMode.light;
      _name = "تم تیره";
      _icon = Icons.dark_mode;
      _color = Colors.white;
      saveTheme(false);
    }
    notifyListeners();
  }

  saveTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDarkMode", isDarkMode);
  }

  Future<bool> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isDarkMode") ?? false;
  }
}
