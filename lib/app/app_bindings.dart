import 'package:chirp/app/core/cubit/auth_cubit.dart';
import 'package:chirp/app/core/utils/uuid_generator.dart';
import 'package:chirp/app/features/welcome/welcome_bindings.dart';
import 'package:get/instance_manager.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<HiveInterface>(Hive);
    Get.put(const Uuid());
    Get.put<UuidGenerator>(UuidGeneratorImpl(Get.find()));
    WelcomeBinding.export();
    Get.put(AuthCubit(Get.find(), Get.find()), permanent: true);
  }
}
