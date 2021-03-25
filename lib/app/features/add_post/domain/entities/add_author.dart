import 'package:chirp/app/core/entities/author.dart';

class AddAuthor extends Author {
  const AddAuthor({
    required String id,
    required String authorName,
  }) : super(authorName: authorName, id: id);

  @override
  List<Object?> get props => [id, authorName];
}
