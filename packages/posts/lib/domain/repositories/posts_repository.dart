import 'package:core/entities/post.dart';
import 'package:core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
}
