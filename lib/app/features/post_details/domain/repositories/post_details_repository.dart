import 'package:dartz/dartz.dart';

import '../../../../core/entities/post.dart';
import '../../../../core/error/failure.dart';

abstract class PostDetailsRepository {
  Future<Either<Failure, Post>> editPost(String uidPost, String newContent);
  Future<Either<Failure, Unit>> deletePost(String uidPost);
}
