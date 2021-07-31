import 'package:add_post/add_post_bindings.dart';
import 'package:add_post/presentation/pages/add_post_page.dart';
import 'package:get/get.dart';
import 'package:post_details/post_details_bindings.dart';
import 'package:post_details/presentation/pages/post_details_page.dart';
import 'package:posts/posts_bindings.dart';
import 'package:posts/presentation/pages/posts_page.dart';
import 'package:welcome/presentation/pages/welcome_page.dart';
import 'package:welcome/welcome_bindings.dart';

mixin Routes {
  static List<GetPage> get all => [
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
      ];
}
