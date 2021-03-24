import 'package:chirp/app/features/welcome/data/models/user_model.dart';
import 'package:chirp/app/features/welcome/domain/entities/logged_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tUserModel = UserModel(name: "Rodrigo Pequeno");

  test(
    'should be a subclass of LoggedUser entity',
    () async {
      // assert
      expect(tUserModel, isA<LoggedUser>());
    },
  );
}
