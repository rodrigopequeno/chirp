import 'package:dartz/dartz.dart';

import '../../../../core/entities/post.dart';
import '../../../../core/error/failure.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
}
