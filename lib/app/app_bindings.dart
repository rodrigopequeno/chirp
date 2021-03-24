import 'package:chirp/app/core/cubit/auth_cubit.dart';
import 'package:chirp/app/features/welcome/welcome_bindings.dart';
import 'package:get/instance_manager.dart';
import 'package:hive/hive.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<HiveInterface>(Hive);
    WelcomeBinding.export();
    Get.put(AuthCubit(Get.find(), Get.find()), permanent: true);
  }
}
