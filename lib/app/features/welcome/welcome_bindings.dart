import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/instance_manager.dart';

import 'data/datasources/welcome_data_source.dart';
import 'data/repositories/welcome_repository_impl.dart';
import 'domain/repositories/welcome_repository.dart';
import 'domain/usecases/get_logged_user.dart';
import 'domain/usecases/sign_in_with_name.dart';
import 'domain/usecases/sign_out.dart';
import 'presentation/cubit/welcome_cubit.dart';

class WelcomeBinding implements Bindings {
  static void export() {
    // Use cases
    Get.lazyPut(() => GetLoggedUser(Get.find()), fenix: true);
    Get.lazyPut(() => SignOut(Get.find()), fenix: true);

    // Repository
    Get.lazyPut<WelcomeRepository>(
        () => WelcomeRepositoryImpl(welcomeDataSource: Get.find()),
        fenix: true);

    // Data sources
    Get.lazyPut<WelcomeDataSource>(
        () => WelcomeDataSourceImpl(Get.find(), Get.find()),
        fenix: true);
  }

  @override
  void dependencies() {
    // Bloc
    Get.create(() => WelcomeCubit(Get.find(), Get.find()));

    // Use cases
    Get.lazyPut(() => SignInWithName(Get.find()), fenix: true);
  }
}
