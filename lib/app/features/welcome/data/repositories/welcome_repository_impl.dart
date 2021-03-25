import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/logged_user.dart';
import '../../domain/repositories/welcome_repository.dart';
import '../datasources/welcome_data_source.dart';

class WelcomeRepositoryImpl extends WelcomeRepository {
  final WelcomeDataSource welcomeDataSource;

  WelcomeRepositoryImpl({required this.welcomeDataSource});

  @override
  Future<Either<Failure, LoggedUser>> signInWithName(String name) async {
    try {
      final user = await welcomeDataSource.signInWithName(name: name);
      return Right(user);
    } catch (e) {
      return Left(SignInFailure());
    }
  }

  @override
  Future<Either<Failure, LoggedUser>> getLoggedUser() async {
    try {
      final user = await welcomeDataSource.getLoggedUser();
      return Right(user);
    } catch (e) {
      return Left(UserNotLoggedInFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    await welcomeDataSource.signOut();
    return const Right(unit);
  }
}
