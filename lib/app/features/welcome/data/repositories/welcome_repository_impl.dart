import 'package:chirp/app/features/welcome/data/datasources/welcome_data_source.dart';
import 'package:chirp/app/features/welcome/domain/entities/logged_user.dart';
import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/features/welcome/domain/repositories/welcome_repository.dart';
import 'package:dartz/dartz.dart';

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
