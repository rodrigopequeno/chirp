import 'package:equatable/equatable.dart';

import 'add_author.dart';

class AddPost extends Equatable {
  final String id;
  final AddAuthor author;
  final DateTime published;
  final String content;

  const AddPost({
    required this.id,
    required this.author,
    required this.published,
    required this.content,
  });

  @override
  List<Object?> get props => [id, author, published, content];
}
