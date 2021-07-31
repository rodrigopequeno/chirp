import 'package:core/entities/post.dart';
import 'package:core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PostDetailsRepository {
  Future<Either<Failure, Post>> editPost(String uidPost, String newContent);
  Future<Either<Failure, Unit>> deletePost(String uidPost);
}
