import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/logged_user.dart';

abstract class WelcomeRepository {
  Future<Either<Failure, LoggedUser>> signInWithName(String name);
  Future<Either<Failure, LoggedUser>> getLoggedUser();
  Future<Either<Failure, Unit>> signOut();
}
