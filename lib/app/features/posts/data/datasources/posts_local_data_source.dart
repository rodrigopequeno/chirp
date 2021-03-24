import 'dart:async';

import 'package:chirp/app/features/posts/data/models/post_model.dart';
import 'package:hive/hive.dart';

import '../../../../core/error/exceptions.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getLastPosts();
  Future<void> cachePosts(List<PostModel> postsToCache);
}

const kCachedPosts = "CACHED_POSTS";

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final HiveInterface hive;

  PostsLocalDataSourceImpl({required this.hive}) {
    hive.registerAdapter<PostModel>(PostModelAdapter());
  }

  @override
  Future<void> cachePosts(List<PostModel> postsToCache) async {
    final box = await _openBox(kCachedPosts);
    box.put(kCachedPosts, postsToCache);
  }

  @override
  Future<List<PostModel>> getLastPosts() async {
    final box = await _openBox(kCachedPosts);
    final posts = box.get(kCachedPosts);
    if (posts == null) {
      throw NotFoundPostsCachedException();
    }
    return Future.value(List<PostModel>.from(posts as List));
  }

  Future<Box> _openBox(String type) async {
    final box = await hive.openBox(type);
    return box;
  }
}
