import 'package:chirp/app/core/entities/post.dart';
import 'package:chirp/app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
}
