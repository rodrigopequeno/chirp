import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/welcome_repository.dart';

class SignOut implements UseCase<Unit, NoParams> {
  final WelcomeRepository _repository;

  SignOut(this._repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await _repository.signOut();
  }
}
