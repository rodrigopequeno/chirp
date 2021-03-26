import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
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
