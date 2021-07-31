import 'package:core/error/exceptions.dart';
import 'package:core/models/post_model.dart';
import 'package:core/utils/constants.dart';
import 'package:hive/hive.dart';

abstract class PostDetailsDataSource {
  Future<PostModel> editPost(String uid, String newContent);
  Future<void> deletePost(String uid);
}

class PostDetailsDataSourceImpl implements PostDetailsDataSource {
  final HiveInterface hive;

  PostDetailsDataSourceImpl(this.hive);

  @override
  Future<void> deletePost(String uid) async {
    try {
      final box = await _openBox(kPosts);
      final data = box.get(kPosts, defaultValue: []);
      final posts = List<PostModel>.from(data as List);
      final deletePost = posts.firstWhere((element) => element.id == uid,
          orElse: () => throw NotFoundPostException());
      posts.remove(deletePost);
      box.put(kPosts, posts);
    } on NotFoundPostException {
      rethrow;
    } catch (e) {
      throw DeletePostException();
    }
  }

  @override
  Future<PostModel> editPost(String uid, String newContent) async {
    try {
      final box = await _openBox(kPosts);
      final data = box.get(kPosts, defaultValue: []);
      final posts = List<PostModel>.from(data as List);
      for (var index = 0; index < posts.length; index++) {
        final post = posts[index];
        if (post.id == uid) {
          final newPost = post.copyWith(content: newContent);
          posts[index] = newPost;
          box.put(kPosts, posts);
          return newPost;
        }
      }
      throw NotFoundPostException();
    } on NotFoundPostException {
      rethrow;
    } catch (e) {
      throw EditPostException();
    }
  }

  Future<Box> _openBox(String type) async {
    final box = await hive.openBox(type);
    return box;
  }
}
