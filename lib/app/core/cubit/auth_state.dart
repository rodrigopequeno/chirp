part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  final List properties;

  const AuthState([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => properties;
}

class AuthInitial extends AuthState {}

class AuthDisconnected extends AuthState {}

class AuthLogged extends AuthState {
  final LoggedUser user;

  AuthLogged(this.user) : super([user]);
}
