import 'package:chirp/app/core/entities/author.dart';
import 'package:chirp/app/core/entities/post.dart';

class ListingPost extends Post {
  const ListingPost({
    required String id,
    required Author author,
    required DateTime published,
    required String content,
  }) : super(author: author, content: content, id: id, published: published);

  @override
  List<Object?> get props => [id, author, published, content];
}
