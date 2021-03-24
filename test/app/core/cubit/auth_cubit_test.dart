import 'package:bloc_test/bloc_test.dart';
import 'package:chirp/app/core/cubit/auth_cubit.dart';
import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/core/usecases/usecase.dart';
import 'package:chirp/app/features/welcome/domain/entities/logged_user.dart';
import 'package:chirp/app/features/welcome/domain/usecases/get_logged_user.dart';
import 'package:chirp/app/features/welcome/domain/usecases/sign_out.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetLoggedUser extends Mock implements GetLoggedUser {}

class MockSignOut extends Mock implements SignOut {}

void main() {
  late AuthCubit cubit;
  late MockGetLoggedUser mockGetLoggedUser;
  late MockSignOut mockSignOut;

  const tName = "Rodrigo Pequeno";
  const tLoggedUser = LoggedUser(name: tName);

  setUpAll(() {
    registerFallbackValue<NoParams>(const NoParams());
  });

  setUp(() {
    mockGetLoggedUser = MockGetLoggedUser();
    mockSignOut = MockSignOut();

    cubit = AuthCubit(mockGetLoggedUser, mockSignOut);
  });

  tearDown(() {
    cubit.close();
  });

  test('initialState should be AuthInitial', () async {
    expect(cubit.state, isA<AuthInitial>());
  });

  group('checkSignIn', () {
    blocTest<AuthCubit, AuthState>(
      'should call getLoggedUser',
      build: () {
        when(() => mockGetLoggedUser(any()))
            .thenAnswer((_) async => const Right(tLoggedUser));
        return cubit;
      },
      act: (cubit) async {
        await cubit.checkSignIn();
      },
      verify: (cubit) async {
        return verify(() => mockGetLoggedUser(any()));
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emit [AuthLogged] when you already have user data',
      build: () {
        when(() => mockGetLoggedUser(any()))
            .thenAnswer((_) async => const Right(tLoggedUser));
        return cubit;
      },
      act: (cubit) async {
        await cubit.checkSignIn();
      },
      expect: () => [AuthLogged(tLoggedUser)],
      verify: (cubit) async {
        return verify(() => mockGetLoggedUser(any()));
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emit [AuthDisconnected] when there is no user data',
      build: () {
        when(() => mockGetLoggedUser(any()))
            .thenAnswer((_) async => Left(UserNotLoggedInFailure()));
        return cubit;
      },
      act: (cubit) async {
        await cubit.checkSignIn();
      },
      expect: () => [AuthDisconnected()],
      verify: (cubit) async {
        return verify(() => mockGetLoggedUser(any()));
      },
    );
  });
  group('logout', () {
    blocTest<AuthCubit, AuthState>(
      'should call signOut',
      build: () {
        when(() => mockSignOut(any()))
            .thenAnswer((_) async => const Right(unit));
        return cubit;
      },
      act: (cubit) async {
        await cubit.logout();
      },
      verify: (cubit) async {
        return verify(() => mockSignOut(any()));
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emit [AuthDisconnected] when end logout',
      build: () {
        when(() => mockSignOut(any()))
            .thenAnswer((_) async => const Right(unit));
        return cubit;
      },
      act: (cubit) async {
        await cubit.logout();
      },
      expect: () => [AuthDisconnected()],
      verify: (cubit) async {
        return verify(() => mockSignOut(any()));
      },
    );
  });
}
