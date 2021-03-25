import 'package:chirp/app/core/cubit/auth_cubit.dart';
import 'package:chirp/app/core/utils/character_limit.dart';
import 'package:chirp/app/core/utils/uuid_generator.dart';
import 'package:chirp/app/features/welcome/welcome_bindings.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:uuid/uuid.dart';

import 'core/network/network_info.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<HiveInterface>(Hive);
    Get.put(const Uuid(), permanent: true);
    Get.put<UuidGenerator>(UuidGeneratorImpl(Get.find()), permanent: true);
    WelcomeBinding.export();
    Get.put(AuthCubit(Get.find(), Get.find()), permanent: true);
    Get.lazyPut(() => Dio(), fenix: true);
    Get.lazyPut(() => InternetConnectionChecker(), fenix: true);
    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(Get.find()), fenix: true);
    Get.lazyPut(() => CharacterLimit(), fenix: true);
  }
}
