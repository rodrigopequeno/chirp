import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String id;
  final String authorName;
  final DateTime published;
  final String content;

  const Post({
    required this.id,
    required this.authorName,
    required this.published,
    required this.content,
  });

  @override
  List<Object?> get props =>
      [id, authorName, published.millisecondsSinceEpoch, content];
}
