import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Chirp',
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => Container()),
    ],
  ));
}
