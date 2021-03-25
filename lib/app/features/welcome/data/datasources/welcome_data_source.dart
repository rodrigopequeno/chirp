import 'package:chirp/app/core/error/exceptions.dart';
import 'package:chirp/app/core/utils/uuid_generator.dart';
import 'package:chirp/app/features/welcome/data/models/user_model.dart';
import 'package:chirp/app/features/welcome/domain/entities/logged_user.dart';
import 'package:hive/hive.dart';

abstract class WelcomeDataSource {
  Future<UserModel> signInWithName({required String name});
  Future<UserModel> getLoggedUser();
  Future<void> signOut();
}

const kBoxUserInfo = "BOX_USER_INFO";

class WelcomeDataSourceImpl implements WelcomeDataSource {
  final HiveInterface hive;
  final UuidGenerator uuid;

  WelcomeDataSourceImpl(this.hive, this.uuid) {
    if (!hive.isAdapterRegistered(UserModelAdapter().typeId)) {
      hive.registerAdapter<UserModel>(UserModelAdapter());
    }
  }

  @override
  Future<UserModel> signInWithName({required String name}) async {
    try {
      final user = UserModel(uid: uuid.generated, name: name);
      final box = await _openBox(kBoxUserInfo);
      box.put(kBoxUserInfo, user);
      return user;
    } catch (e) {
      throw SignInException();
    }
  }

  @override
  Future<UserModel> getLoggedUser() async {
    final box = await _openBox(kBoxUserInfo);

    final user = box.get(kBoxUserInfo);
    if (user == null) throw UserNotLoggedInException();
    final loggedUser = user as LoggedUser;
    return UserModel(uid: loggedUser.uid, name: loggedUser.name);
  }

  @override
  Future<void> signOut() async {
    final box = await _openBox(kBoxUserInfo);
    await box.clear();
  }

  Future<Box> _openBox(String type) async {
    final box = await hive.openBox(type);
    return box;
  }
}
