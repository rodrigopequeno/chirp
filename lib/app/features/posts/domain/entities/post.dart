import '../../../../core/entities/author.dart';
import '../../../../core/entities/post.dart';

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
