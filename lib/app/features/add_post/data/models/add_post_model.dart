import '../../../../core/entities/author.dart';
import '../../../../core/models/post_model.dart';

class AddPostModel extends PostModel {
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
