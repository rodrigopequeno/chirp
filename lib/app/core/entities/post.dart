import 'package:equatable/equatable.dart';

import 'author.dart';

class Post extends Equatable implements Comparable<Post> {
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

  @override
  int compareTo(Post other) {
    if (other.published.compareTo(published) != 0) {
      return other.published.compareTo(published);
    } else if (other.author.authorName.compareTo(author.authorName) != 0) {
      return other.author.authorName.compareTo(author.authorName);
    } else if (other.content.compareTo(content) != 0) {
      return other.content.compareTo(content);
    } else if (other.id.compareTo(id) != 0) {
      return other.id.compareTo(id);
    }
    return 0;
  }
}
