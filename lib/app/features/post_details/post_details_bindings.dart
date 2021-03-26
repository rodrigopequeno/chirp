import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/instance_manager.dart';

import 'data/datasources/post_details_data_source.dart';
import 'data/repositories/post_details_repository_impl.dart';
import 'domain/repositories/post_details_repository.dart';
import 'domain/usecases/delete_post.dart';
import 'domain/usecases/edit_post.dart';
import 'presentation/cubit/post_details_cubit.dart';

class PostDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.create(() => PostDetailsCubit(Get.find(), Get.find()));
    // Use cases
    Get.lazyPut(() => EditPost(Get.find()), fenix: true);
    Get.lazyPut(() => DeletePost(Get.find()), fenix: true);

    // Repository
    Get.lazyPut<PostDetailsRepository>(
        () => PostDetailsRepositoryImpl(
              detailsDataSource: Get.find(),
            ),
        fenix: true);

    // Data sources
    Get.lazyPut<PostDetailsDataSource>(
        () => PostDetailsDataSourceImpl(Get.find()),
        fenix: true);
  }
}
