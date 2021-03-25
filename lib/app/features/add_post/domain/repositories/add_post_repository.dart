import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/features/add_post/domain/entities/add_post.dart';
import 'package:dartz/dartz.dart';

abstract class AddPostRepository {
  Future<Either<Failure, AddPost>> addPost(AddPost post);
}
