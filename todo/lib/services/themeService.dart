import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class themeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  _saveTheme(bool value) {
    _box.write(_key, value);
  }

  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveTheme(!_loadThemeFromBox());
  }
}
