import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/database/databaseHelper.dart';
import 'package:todo/services/themeService.dart';
import 'package:todo/views/homeScreen.dart';
import 'package:todo/views/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await databaseHelper.initDB();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themes.light,
      darkTheme: themes.dark,
      themeMode: themeService().theme,
      home: const homeScreen(),
    );
  }
}
