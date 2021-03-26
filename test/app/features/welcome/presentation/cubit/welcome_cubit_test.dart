import 'package:bloc_test/bloc_test.dart';
import 'package:chirp/app/core/cubit/auth_cubit.dart';
import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/features/welcome/domain/entities/logged_user.dart';
import 'package:chirp/app/features/welcome/domain/usecases/sign_in_with_name.dart';
import 'package:chirp/app/features/welcome/presentation/cubit/welcome_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignInWithName extends Mock implements SignInWithName {}

class MockAuthCubit extends Mock implements AuthCubit {}

void main() {
  late WelcomeCubit cubit;
  late SignInWithName mockSignInWithName;
  late MockAuthCubit mockAuthCubit;

  const tName = "Rodrigo Pequeno";
  const tUuid = "88f01b0d-f4fe-4e5f-815c-dba8fbc19427";
  const tLoggedUser = LoggedUser(name: tName, uid: tUuid);

  setUpAll(() {
    registerFallbackValue<Params>(const Params(name: tName));
  });

  setUp(() {
    mockSignInWithName = MockSignInWithName();
    mockAuthCubit = MockAuthCubit();

    cubit = WelcomeCubit(mockSignInWithName, mockAuthCubit);
    when(() => mockAuthCubit.checkSignIn()).thenAnswer((_) async => {});
  });

  tearDown(() {
    cubit.close();
  });

  test('initialState should be WelcomeLoadingInitial', () async {
    expect(cubit.state, isA<WelcomeLoadingInitial>());
  });

  group('init', () {
    blocTest<WelcomeCubit, WelcomeState>(
      'should call checkSignIn',
      build: () {
        when(() => mockAuthCubit.state).thenReturn(AuthDisconnected());
        return cubit;
      },
      act: (cubit) async {
        await cubit.init();
      },
      verify: (cubit) async {
        await untilCalled(() => mockAuthCubit.checkSignIn());
        return verify(() => mockAuthCubit.checkSignIn());
      },
    );

    blocTest<WelcomeCubit, WelcomeState>(
      'should emit [WelcomeInitial] when AuthDisconnected',
      build: () {
        when(() => mockAuthCubit.state).thenReturn(AuthDisconnected());

        return cubit;
      },
      act: (cubit) async {
        await cubit.init();
        await untilCalled(() => mockAuthCubit.checkSignIn());
      },
      expect: () => [WelcomeInitial()],
      verify: (cubit) async {
        return verify(() => mockAuthCubit.checkSignIn());
      },
    );

    blocTest<WelcomeCubit, WelcomeState>(
      'should emit [WelcomeSuccess] when AuthLogged',
      build: () {
        when(() => mockAuthCubit.state).thenReturn(AuthLogged(tLoggedUser));
        return cubit;
      },
      act: (cubit) async {
        await cubit.init();
        await untilCalled(() => mockAuthCubit.checkSignIn());
      },
      expect: () => [WelcomeSuccess()],
      verify: (cubit) async {
        return verify(() => mockAuthCubit.checkSignIn());
      },
    );
  });

  group('signIn', () {
    blocTest<WelcomeCubit, WelcomeState>(
      'should enter with use case',
      build: () {
        when(() => mockSignInWithName(any()))
            .thenAnswer((_) async => const Right(tLoggedUser));
        return cubit;
      },
      act: (cubit) => cubit.signIn(tName),
      verify: (cubit) async {
        await untilCalled(() => mockSignInWithName(any()));
        return verify(() => mockSignInWithName(any()));
      },
    );

    blocTest<WelcomeCubit, WelcomeState>(
      'should emit [WelcomeInitial, WelcomeLoading, WelcomeSuccess] when enter successfully',
      build: () {
        when(() => mockSignInWithName(any()))
            .thenAnswer((_) async => const Right(tLoggedUser));
        return cubit;
      },
      act: (cubit) async {
        cubit.signIn(tName);
        await untilCalled(() => mockSignInWithName(any()));
      },
      expect: () => [WelcomeInitial(), WelcomeLoading(), WelcomeSuccess()],
    );

    blocTest<WelcomeCubit, WelcomeState>(
      'should emit [WelcomeInitial, WelcomeLoading, WelcomeError] when an error occurs trying to enter',
      build: () {
        when(() => mockSignInWithName(any()))
            .thenAnswer((_) async => Left(SignInFailure()));
        return cubit;
      },
      act: (cubit) async {
        cubit.signIn(tName);
        await untilCalled(() => mockSignInWithName(any()));
      },
      expect: () => [
        WelcomeInitial(),
        WelcomeLoading(),
        WelcomeError(kSignInFailureMessage)
      ],
    );

    blocTest<WelcomeCubit, WelcomeState>(
      'should call checkSignIn after WelcomeSuccess',
      build: () {
        when(() => mockSignInWithName(any()))
            .thenAnswer((_) async => const Right(tLoggedUser));
        return cubit;
      },
      act: (cubit) async {
        cubit.signIn(tName);
        await untilCalled(() => mockSignInWithName(any()));
      },
      expect: () => [WelcomeInitial(), WelcomeLoading(), WelcomeSuccess()],
      verify: (cubit) async {
        await untilCalled(() => mockAuthCubit.checkSignIn());
        return verify(() => mockAuthCubit.checkSignIn());
      },
    );
  });
}
