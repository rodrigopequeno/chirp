part of 'welcome_cubit.dart';

abstract class WelcomeState extends Equatable {
  final List properties;

  const WelcomeState([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class WelcomeLoadingInitial extends WelcomeState {}

class WelcomeInitial extends WelcomeState {}

class WelcomeLoading extends WelcomeState {}

class WelcomeSuccess extends WelcomeState {}

class WelcomeError extends WelcomeState {
  final String message;

  WelcomeError(this.message) : super([message]);
}
