import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/features/add_post/data/models/add_post_model.dart';
import 'package:dartz/dartz.dart';

abstract class AddPostRepository {
  Future<Either<Failure, Unit>> addPost(AddPostModel post);
}
