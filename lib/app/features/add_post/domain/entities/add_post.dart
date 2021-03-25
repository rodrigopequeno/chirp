import '../../../../core/entities/post.dart';
import 'add_author.dart';

class AddPost extends Post {
  const AddPost({
    required String id,
    required AddAuthor author,
    required DateTime published,
    required String content,
  }) : super(author: author, content: content, id: id, published: published);

  @override
  List<Object?> get props => [id, author, published, content];
}
