import 'package:chirp/app/features/posts/data/datasources/posts_local_data_source.dart';
import 'package:chirp/app/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:chirp/app/features/posts/domain/repositories/posts_repository.dart';
import 'package:chirp/app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:chirp/app/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/instance_manager.dart';

import 'data/repositories/posts_repository_impl.dart';

class PostsBinding implements Bindings {
  static void export() {}

  @override
  void dependencies() {
    export();
    // Bloc
    Get.create(() => PostsCubit(Get.find()));

    // Use cases
    Get.lazyPut(() => GetAllPosts(Get.find()), fenix: true);

    // Repository
    Get.lazyPut<PostsRepository>(
        () => PostsRepositoryImpl(
              localDataSource: Get.find(),
              remoteDataSource: Get.find(),
              networkInfo: Get.find(),
              characterLimit: Get.find(),
            ),
        fenix: true);

    // Data sources
    Get.lazyPut<PostsLocalDataSource>(
        () => PostsLocalDataSourceImpl(hive: Get.find()),
        fenix: true);
    Get.lazyPut<PostsRemoteDataSource>(
        () => PostsRemoteDataSourceImpl(client: Get.find()),
        fenix: true);
  }
}
