import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/instance_manager.dart';

import 'data/datasources/posts_local_data_source.dart';
import 'data/datasources/posts_remote_data_source.dart';
import 'data/repositories/posts_repository_impl.dart';
import 'domain/repositories/posts_repository.dart';
import 'domain/usecases/get_all_posts.dart';
import 'presentation/cubit/posts_cubit.dart';

class PostsBinding implements Bindings {
  @override
  void dependencies() {
    Get.create(() => PostsCubit(Get.find()));
    Get.lazyPut(() => GetAllPosts(Get.find()), fenix: true);
    Get.lazyPut<PostsRepository>(
        () => PostsRepositoryImpl(
              localDataSource: Get.find(),
              remoteDataSource: Get.find(),
              networkInfo: Get.find(),
              characterLimit: Get.find(),
            ),
        fenix: true);
    Get.lazyPut<PostsLocalDataSource>(
        () => PostsLocalDataSourceImpl(hive: Get.find()),
        fenix: true);
    Get.lazyPut<PostsRemoteDataSource>(
        () => PostsRemoteDataSourceImpl(client: Get.find()),
        fenix: true);
  }
}
