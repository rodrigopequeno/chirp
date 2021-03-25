import 'package:chirp/app/core/entities/post.dart';
import 'package:chirp/app/features/add_post/data/models/add_author_model.dart';
import 'package:chirp/app/features/add_post/data/models/add_post_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tAddAuthorModel = AddAuthorModel(id: '0', authorName: "Rodrigo");
  final tAddPostModel = AddPostModel(
      author: tAddAuthorModel,
      content: "Hello",
      id: "0",
      published: DateTime.now());

  test('should be a subclass of Post entity', () async {
    expect(tAddPostModel, isA<Post>());
  });
}
