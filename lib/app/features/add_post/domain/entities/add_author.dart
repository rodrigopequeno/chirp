import 'package:equatable/equatable.dart';

class AddAuthor extends Equatable {
  final String id;
  final String authorName;

  const AddAuthor({
    required this.id,
    required this.authorName,
  });

  @override
  List<Object?> get props => [id, authorName];
}
