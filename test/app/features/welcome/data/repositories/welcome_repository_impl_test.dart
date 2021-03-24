import 'package:chirp/app/core/error/exceptions.dart';
import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/features/welcome/data/datasources/welcome_data_source.dart';
import 'package:chirp/app/features/welcome/data/models/user_model.dart';
import 'package:chirp/app/features/welcome/data/repositories/welcome_repository_impl.dart';
import 'package:chirp/app/features/welcome/domain/repositories/welcome_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWelcomeDataSource extends Mock implements WelcomeDataSource {}

void main() {
  late WelcomeRepository repository;
  late MockWelcomeDataSource mockWelcomeDataSource;

  setUp(() {
    mockWelcomeDataSource = MockWelcomeDataSource();
    repository =
        WelcomeRepositoryImpl(welcomeDataSource: mockWelcomeDataSource);
  });

  const tUuid = "88f01b0d-f4fe-4e5f-815c-dba8fbc19427";
  const tName = "Rodrigo Pequeno";
  const tUserReturn = UserModel(name: tName, uid: tUuid);

  group("signInWithName", () {
    test(
        'should return data when the call to sign in data source is successful',
        () async {
      when(() => mockWelcomeDataSource.signInWithName(name: tName))
          .thenAnswer((_) async => tUserReturn);
      final result = await repository.signInWithName(tName);
      verify(() => mockWelcomeDataSource.signInWithName(name: tName));
      expect(result, equals(const Right(tUserReturn)));
    });
    test(
        'should return sign in failure when the call to sign in data source is unsuccessful',
        () async {
      when(() => mockWelcomeDataSource.signInWithName(name: tName))
          .thenThrow(SignInException());
      final result = await repository.signInWithName(tName);
      expect(result, equals(Left(SignInFailure())));
    });
  });

  group("getLoggedUser", () {
    test(
        'should return current user when the call to login data source is successful',
        () async {
      when(() => mockWelcomeDataSource.getLoggedUser())
          .thenAnswer((_) async => tUserReturn);
      final result = await repository.getLoggedUser();
      verify(() => mockWelcomeDataSource.getLoggedUser());
      expect(result, equals(const Right(tUserReturn)));
    });
    test(
        'should return get logged user failure when the call to login data source is unsuccessful',
        () async {
      when(() => mockWelcomeDataSource.getLoggedUser())
          .thenThrow(UserNotLoggedInException());
      final result = await repository.getLoggedUser();
      expect(result, equals(Left(UserNotLoggedInFailure())));
    });
  });

  group("signOut", () {
    test('should log out the current user', () async {
      when(() => mockWelcomeDataSource.signOut()).thenAnswer((_) async {});
      final result = await repository.signOut();
      verify(() => mockWelcomeDataSource.signOut());
      expect(result, equals(const Right(unit)));
    });
  });
}
