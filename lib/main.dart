import 'package:chirp/app/features/posts/posts_bindings.dart';
import 'package:chirp/app/features/posts/presentation/pages/posts_page.dart';
import 'package:chirp/app/features/welcome/presentation/pages/welcome_page.dart';
import 'package:chirp/app/features/welcome/welcome_bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:asuka/asuka.dart' as asuka;

import 'app/app_bindings.dart';

Future<void> main() async {
  await Hive.initFlutter();
  runApp(
    GetMaterialApp(
      title: 'Chirp',
      initialRoute: '/',
      initialBinding: AppBindings(),
      builder: asuka.builder,
      getPages: [
        GetPage(
          name: '/',
          page: () => const WelcomePage(),
          binding: WelcomeBinding(),
        ),
        GetPage(
          name: '/posts',
          page: () => const PostsPage(),
          binding: PostsBinding(),
        ),
      ],
    ),
  );
}
