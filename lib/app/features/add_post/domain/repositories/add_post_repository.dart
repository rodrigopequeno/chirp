import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/add_post_model.dart';

abstract class AddPostRepository {
  Future<Either<Failure, Unit>> addPost(AddPostModel post);
}
