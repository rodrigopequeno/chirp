import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'data/datasources/add_post_data_source.dart';
import 'data/repositories/add_post_repository_impl.dart';
import 'domain/repositories/add_post_repository.dart';
import 'domain/usecases/create_post.dart';
import 'presentation/cubit/add_post_cubit.dart';

class AddPostBindings implements Bindings {
  static void export() {}

  @override
  void dependencies() {
    export();
    // Bloc
    Get.create(
        () => AddPostCubit(Get.find(), Get.find(), Get.find(), Get.find()));

    // Use cases
    Get.lazyPut(() => CreatePost(Get.find()), fenix: true);

    // Repository
    Get.lazyPut<AddPostRepository>(
        () => AddPostRepositoryImpl(
              addPostDataSource: Get.find(),
            ),
        fenix: true);

    // Data sources
    Get.lazyPut<AddPostDataSource>(() => AddPostDataSourceImpl(Get.find()),
        fenix: true);
  }
}
