import 'package:welcome/domain/entities/logged_user.dart';
import 'package:welcome/domain/repositories/welcome_repository.dart';
import 'package:welcome/domain/usecases/sign_in_with_name.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWelcomeRepository extends Mock implements WelcomeRepository {}

void main() {
  late SignInWithName usecase;
  late MockWelcomeRepository mockWelcomeRepository;

  setUp(() {
    mockWelcomeRepository = MockWelcomeRepository();
    usecase = SignInWithName(mockWelcomeRepository);
  });

  const tName = "Rodrigo Pequeno";
  const tUuid = "88f01b0d-f4fe-4e5f-815c-dba8fbc19427";
  const tUser = LoggedUser(name: tName, uid: tUuid);

  test('should welcome with name through the repository', () async {
    when(() => mockWelcomeRepository.signInWithName(any<String>()))
        .thenAnswer((_) async => const Right(tUser));

    final result = await usecase(const Params(name: tName));

    expect(result, const Right(tUser));
    verify(() => mockWelcomeRepository.signInWithName(tName));
    verifyNoMoreInteractions(mockWelcomeRepository);
  });
}
