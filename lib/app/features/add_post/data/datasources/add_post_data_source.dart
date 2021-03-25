import 'package:hive/hive.dart';

import '../../../../core/models/post_model.dart';
import '../../../../core/utils/constants.dart';
import '../models/add_post_model.dart';

abstract class AddPostDataSource {
  Future<void> createPost(AddPostModel addPostModel);
}

class AddPostDataSourceImpl implements AddPostDataSource {
  final HiveInterface hive;

  AddPostDataSourceImpl(this.hive);

  Future<Box> _openBox(String type) async {
    final box = await hive.openBox(type);
    return box;
  }

  @override
  Future<void> createPost(AddPostModel addPostModel) async {
    final box = await _openBox(kPosts);
    final posts = box.get(kPosts, defaultValue: []);
    final newPosts = List<PostModel>.from(posts as List)..add(addPostModel);
    box.put(kPosts, newPosts);
  }
}
