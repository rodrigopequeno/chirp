import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'data/datasources/add_post_data_source.dart';
import 'data/repositories/add_post_repository_impl.dart';
import 'domain/repositories/add_post_repository.dart';
import 'domain/usecases/create_post.dart';
import 'presentation/cubit/add_post_cubit.dart';

class AddPostBindings implements Bindings {
  @override
  void dependencies() {
    Get.create(
        () => AddPostCubit(Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => CreatePost(Get.find()), fenix: true);
    Get.lazyPut<AddPostRepository>(
        () => AddPostRepositoryImpl(
              addPostDataSource: Get.find(),
            ),
        fenix: true);
    Get.lazyPut<AddPostDataSource>(() => AddPostDataSourceImpl(Get.find()),
        fenix: true);
  }
}
