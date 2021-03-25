import 'package:chirp/app/core/entities/author.dart';
import 'package:equatable/equatable.dart';

abstract class Post extends Equatable {
  final String id;
  final Author author;
  final DateTime published;
  final String content;

  const Post({
    required this.id,
    required this.author,
    required this.published,
    required this.content,
  });

  @override
  List<Object?> get props => [id, author, published, content];
}
