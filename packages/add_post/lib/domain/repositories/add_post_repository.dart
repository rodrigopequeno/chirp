import 'package:core/error/failure.dart';
import 'package:core/models/post_model.dart';
import 'package:dartz/dartz.dart';

abstract class AddPostRepository {
  Future<Either<Failure, Unit>> addPost(PostModel post);
}
