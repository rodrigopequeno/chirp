import 'package:welcome/data/models/user_model.dart';
import 'package:welcome/domain/entities/logged_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tUserModel = UserModel(
      name: "Rodrigo Pequeno", uid: "88f01b0d-f4fe-4e5f-815c-dba8fbc19427");

  test(
    'should be a subclass of LoggedUser entity',
    () async {
      expect(tUserModel, isA<LoggedUser>());
    },
  );
}
