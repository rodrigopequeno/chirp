import 'package:equatable/equatable.dart';

class LoggedUser extends Equatable {
  final String uid;
  final String name;
  final String? image;

  const LoggedUser({
    required this.uid,
    required this.name,
    this.image,
  });
  @override
  List<Object?> get props => [uid, name];
}
