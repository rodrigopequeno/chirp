import 'package:core/error/failure.dart';
import 'package:core/usecases/no_params.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/logged_user.dart';
import '../repositories/welcome_repository.dart';

class GetLoggedUser implements UseCase<LoggedUser, NoParams> {
  final WelcomeRepository _repository;

  GetLoggedUser(this._repository);

  @override
  Future<Either<Failure, LoggedUser>> call(NoParams params) async {
    return await _repository.getLoggedUser();
  }
}
