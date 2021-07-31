import 'package:core/error/exceptions.dart';
import 'package:core/models/post_model.dart';
import 'package:dio/dio.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final Dio client;

  PostsRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PostModel>> getAllPosts() async {
    try {
      // final response =
      //     await client.get('https://api.mocki.io/v1/f932124c/posts');
      // if (response.statusCode == 200) {
      //   return (response.data['Result'] as List)
      //       .map((e) => PostModel.fromMap(e as Map<String, dynamic>))
      //       .toList();
      // } else {
      //   throw ServerException();
      // }
      return <PostModel>[];
    } on DioError {
      throw ServerException();
    }
  }
}
