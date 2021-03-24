import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;

  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => properties;
}

class SignInFailure extends Failure {}

class UserNotLoggedInFailure extends Failure {}

class ServerFailure extends Failure {}

class NotFoundPostsCachedFailure extends Failure {}
