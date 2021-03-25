import 'package:equatable/equatable.dart';

abstract class Author extends Equatable {
  final String id;
  final String authorName;

  const Author({
    required this.id,
    required this.authorName,
  });

  @override
  List<Object?> get props => [id, authorName];
}
