import 'package:equatable/equatable.dart';

class LoggedUser extends Equatable {
  final String uid;
  final String name;

  const LoggedUser({required this.uid, required this.name});
  @override
  List<Object?> get props => [uid, name];
}
