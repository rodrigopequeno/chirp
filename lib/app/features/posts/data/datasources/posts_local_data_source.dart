import 'dart:async';

import 'package:chirp/app/core/utils/constants.dart';
import 'package:chirp/app/features/posts/data/models/author_model.dart';
import 'package:chirp/app/features/posts/data/models/post_model.dart';
import 'package:hive/hive.dart';

import '../../../../core/error/exceptions.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getPosts();
  Future<List<PostModel>> getCachePosts();
  Future<void> cachePosts(List<PostModel> postsToCache);
}

const kCachedPosts = "CACHED_POSTS";

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final HiveInterface hive;

  PostsLocalDataSourceImpl({required this.hive}) {
    if (!hive.isAdapterRegistered(PostModelAdapter().typeId)) {
      hive.registerAdapter<PostModel>(PostModelAdapter());
    }
    if (!hive.isAdapterRegistered(AuthorModelAdapter().typeId)) {
      hive.registerAdapter<AuthorModel>(AuthorModelAdapter());
    }
  }

  @override
  Future<void> cachePosts(List<PostModel> postsToCache) async {
    final box = await _openBox(kCachedPosts);
    box.put(kCachedPosts, postsToCache);
  }

  @override
  Future<List<PostModel>> getCachePosts() async {
    final box = await _openBox(kCachedPosts);
    final posts = box.get(kCachedPosts);
    if (posts == null) {
      throw NotFoundPostsCachedException();
    }
    return Future.value(List<PostModel>.from(posts as List));
  }

  @override
  Future<List<PostModel>> getPosts() async {
    final box = await _openBox(kPosts);
    final posts = box.get(kPosts, defaultValue: []);
    return Future.value(List<PostModel>.from(posts as List));
  }

  Future<Box> _openBox(String type) async {
    final box = await hive.openBox(type);
    return box;
  }
}
