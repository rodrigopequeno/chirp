import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../models/post_model.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final Dio client;

  PostsRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get('https://api.mocki.io/v1/7f811b6a/posts');
    if (response.statusCode == 200) {
      return (response.data['Result'] as List)
          .map((e) => PostModel.fromMap(e as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
