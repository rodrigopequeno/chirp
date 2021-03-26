import 'package:asuka/asuka.dart' as asuka;
import 'package:chirp/app/core/themes/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app_bindings.dart';
import 'app/core/routes/routes.dart';

Future<void> main() async {
  await Hive.initFlutter();
  runApp(
    GetMaterialApp(
      title: 'CHIRP',
      initialRoute: '/',
      initialBinding: AppBindings(),
      builder: asuka.builder,
      theme: ThemeApp.light,
      getPages: Routes.all,
    ),
  );
}
