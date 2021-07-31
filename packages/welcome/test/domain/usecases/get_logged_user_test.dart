import 'package:core/usecases/no_params.dart';
import 'package:welcome/domain/entities/logged_user.dart';
import 'package:welcome/domain/repositories/welcome_repository.dart';
import 'package:welcome/domain/usecases/get_logged_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWelcomeRepository extends Mock implements WelcomeRepository {}

void main() {
  late GetLoggedUser usecase;
  late MockWelcomeRepository mockWelcomeRepository;

  setUp(() {
    mockWelcomeRepository = MockWelcomeRepository();
    usecase = GetLoggedUser(mockWelcomeRepository);
  });

  const tName = "Rodrigo Pequeno";
  const tUuid = "88f01b0d-f4fe-4e5f-815c-dba8fbc19427";
  const tUser = LoggedUser(name: tName, uid: tUuid);

  test('should get the user logged from the repository', () async {
    when(() => mockWelcomeRepository.getLoggedUser())
        .thenAnswer((_) async => const Right(tUser));

    final result = await usecase(const NoParams());

    expect(result, const Right(tUser));
    verify(() => mockWelcomeRepository.getLoggedUser());
    verifyNoMoreInteractions(mockWelcomeRepository);
  });
}
