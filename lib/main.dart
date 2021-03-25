import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app_bindings.dart';
import 'app/features/add_post/add_post_bindings.dart';
import 'app/features/add_post/presentation/pages/add_post_page.dart';
import 'app/features/post_details/post_details_bindings.dart';
import 'app/features/post_details/presentation/pages/post_details_page.dart';
import 'app/features/posts/posts_bindings.dart';
import 'app/features/posts/presentation/pages/posts_page.dart';
import 'app/features/welcome/presentation/pages/welcome_page.dart';
import 'app/features/welcome/welcome_bindings.dart';

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
        GetPage(
          name: '/add-post',
          page: () => AddPostPage(),
          binding: AddPostBindings(),
        ),
        GetPage(
          name: '/details',
          page: () => PostDetailsPage(),
          binding: PostDetailsBinding(),
        ),
      ],
    ),
  );
}
