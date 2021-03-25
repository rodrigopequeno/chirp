import '../../../../core/entities/author.dart';
import '../../../../core/entities/post.dart';
import '../../../posts/data/models/post_model.dart';

class AddPostModel extends PostModel implements Post {
  const AddPostModel(
      {required String id,
      required Author author,
      required DateTime published,
      required String content})
      : super(
          author: author,
          content: content,
          published: published,
          id: id,
        );
}
