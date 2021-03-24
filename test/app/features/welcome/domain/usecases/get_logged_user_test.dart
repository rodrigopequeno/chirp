import 'package:chirp/app/core/usecases/usecase.dart';
import 'package:chirp/app/features/welcome/domain/entities/logged_user.dart';
import 'package:chirp/app/features/welcome/domain/repositories/welcome_repository.dart';
import 'package:chirp/app/features/welcome/domain/usecases/get_logged_user.dart';
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
  const tUser = LoggedUser(name: tName);

  test('should get the user logged from the repository', () async {
    when(() => mockWelcomeRepository.getLoggedUser())
        .thenAnswer((_) async => const Right(tUser));

    final result = await usecase(const NoParams());

    expect(result, const Right(tUser));
    verify(() => mockWelcomeRepository.getLoggedUser());
    verifyNoMoreInteractions(mockWelcomeRepository);
  });
}
