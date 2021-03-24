import 'package:chirp/app/core/cubit/auth_cubit.dart';
import 'package:chirp/app/core/utils/character_limit.dart';
import 'package:chirp/app/features/welcome/welcome_bindings.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/network_info.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<HiveInterface>(Hive);
    WelcomeBinding.export();
    Get.put(AuthCubit(Get.find(), Get.find()), permanent: true);
    Get.lazyPut(() => Dio());
    Get.lazyPut(() => InternetConnectionChecker());
    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(Get.find()));
    Get.lazyPut(() => CharacterLimit());
  }
}
