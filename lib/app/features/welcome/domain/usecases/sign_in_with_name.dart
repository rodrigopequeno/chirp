import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/logged_user.dart';
import '../repositories/welcome_repository.dart';

class SignInWithName implements UseCase<LoggedUser, Params> {
  final WelcomeRepository _repository;

  SignInWithName(this._repository);

  @override
  Future<Either<Failure, LoggedUser>> call(Params params) async {
    return await _repository.signInWithName(params.name);
  }
}

class Params extends Equatable {
  final String name;

  const Params({required this.name});

  @override
  List<Object?> get props => [name];
}
