import 'package:chirp/app/core/entities/author.dart';
import 'package:chirp/app/core/entities/post.dart';
import 'package:chirp/app/features/posts/data/models/post_model.dart';

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
