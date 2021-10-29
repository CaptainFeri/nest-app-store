import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel with ChangeNotifier {
  ThemeMode _mode;
  String _name;
  IconData _icon;
  Color _color;
  Color _textColor;
  Color _cardColor;

  ThemeMode get mode => _mode;

  String get name => _name;

  IconData get icon => _icon;

  Color get color => _color;

  Color get textColor => _textColor;

  Color get cardColor => _cardColor;

  ThemeModel(
      {ThemeMode mode = ThemeMode.light,
      String name = "تم تیره",
      IconData icon = Icons.light_mode,
      Color color = Colors.black,
      Color textColor = Colors.black,
      Color cardColor = Colors.white60})
      : _mode = mode,
        _name = name,
        _icon = icon,
        _color = color,
        _textColor = textColor,
        _cardColor = cardColor{
    loadTheme().then((value) {
      bool isDarkMode = value;
      _mode = (isDarkMode ? ThemeMode.dark : ThemeMode.light);
      _name = (isDarkMode ? "تم روشن" : "تم تیره");
      _icon = (isDarkMode ? Icons.light_mode : Icons.dark_mode);
      _color = (isDarkMode ? Colors.yellow : Colors.white);
      _textColor = (isDarkMode ? Colors.white : Colors.black);
      _cardColor = (isDarkMode ? Colors.black38 : Colors.white60);
      notifyListeners();
    });
  }

  void toggleMode() {
    if (_mode == ThemeMode.light) {
      _mode = ThemeMode.dark;
      _name = "تم روشن";
      _icon = Icons.light_mode;
      _color = Colors.yellow;
      _textColor = Colors.white;
      _cardColor = Colors.black38;
      saveTheme(true);
    } else {
      _mode = ThemeMode.light;
      _name = "تم تیره";
      _icon = Icons.dark_mode;
      _color = Colors.white;
      _textColor = Colors.black;
      _cardColor = Colors.white60;
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
