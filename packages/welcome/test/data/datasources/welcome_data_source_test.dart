import 'package:core/error/exceptions.dart';
import 'package:core/utils/uuid_generator.dart';
import 'package:welcome/data/datasources/welcome_data_source.dart';
import 'package:welcome/domain/entities/logged_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockBox extends Mock implements Box {}

class MockUuidGenerator extends Mock implements UuidGenerator {}

void main() {
  const tName = "Rodrigo Pequeno";
  const tUuid = "88f01b0d-f4fe-4e5f-815c-dba8fbc19427";
  const tUser = LoggedUser(name: tName, uid: tUuid);

  late MockHiveInterface mockHiveInterface;
  late MockBox mockHiveBox;
  late MockUuidGenerator mockUuidGenerator;
  late WelcomeDataSource welcomeDataSourceImpl;

  setUpAll(() {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockBox();
    mockUuidGenerator = MockUuidGenerator();
    when(() => mockHiveInterface.isAdapterRegistered(any())).thenReturn(false);

    welcomeDataSourceImpl =
        WelcomeDataSourceImpl(mockHiveInterface, mockUuidGenerator);
    when(() => mockUuidGenerator.generated).thenReturn(tUuid);
    when(() => mockHiveInterface.openBox(any<String>()))
        .thenAnswer((_) async => mockHiveBox);
  });
  group("signInWithName", () {
    test('should return Logged User', () async {
      when(() => mockHiveBox.put(any(), any())).thenAnswer((_) async => {});

      final result = await welcomeDataSourceImpl.signInWithName(name: tName);
      expect(result.name, equals(tUser.name));
    });
  });

  group("getLoggedUser", () {
    test('should return Logged User', () async {
      when(() => mockHiveBox.get(any<String>())).thenReturn(tUser);
      final result = await welcomeDataSourceImpl.getLoggedUser();
      expect(result.name, equals(tUser.name));
    });

    test('should return UserNotLoggedIn if User is not logged', () async {
      when(() => mockHiveBox.get(any())).thenReturn(null);

      expect(() => welcomeDataSourceImpl.getLoggedUser(),
          throwsA(isA<UserNotLoggedInException>()));
    });
  });

  group("signOut", () {
    test('should complete logout', () async {
      when(() => mockHiveBox.clear()).thenAnswer((_) async => 0);
      expect(welcomeDataSourceImpl.signOut(), completes);
    });
  });
}
