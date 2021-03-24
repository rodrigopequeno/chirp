import 'package:chirp/app/core/usecases/usecase.dart';
import 'package:chirp/app/features/welcome/domain/repositories/welcome_repository.dart';
import 'package:chirp/app/features/welcome/domain/usecases/sign_out.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWelcomeRepository extends Mock implements WelcomeRepository {}

void main() {
  late SignOut usecase;
  late MockWelcomeRepository mockWelcomeRepository;

  setUp(() {
    mockWelcomeRepository = MockWelcomeRepository();
    usecase = SignOut(mockWelcomeRepository);
  });

  test('should log out from the repository', () async {
    when(() => mockWelcomeRepository.signOut())
        .thenAnswer((_) async => const Right(unit));

    final result = await usecase(NoParams());

    expect(result, const Right(unit));
    verify(() => mockWelcomeRepository.signOut());
    verifyNoMoreInteractions(mockWelcomeRepository);
  });
}
