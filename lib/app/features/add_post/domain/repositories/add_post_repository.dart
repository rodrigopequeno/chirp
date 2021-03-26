import 'package:chirp/app/core/models/post_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class AddPostRepository {
  Future<Either<Failure, Unit>> addPost(PostModel post);
}
