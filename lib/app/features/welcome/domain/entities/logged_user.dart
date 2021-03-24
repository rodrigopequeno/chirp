import 'package:equatable/equatable.dart';

class LoggedUser extends Equatable {
  final String name;

  const LoggedUser({required this.name});
  @override
  List<Object?> get props => [name];
}
