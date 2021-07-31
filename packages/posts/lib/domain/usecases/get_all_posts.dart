import 'package:core/entities/post.dart';
import 'package:core/error/failure.dart';
import 'package:core/usecases/no_params.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../repositories/posts_repository.dart';

class GetAllPosts implements UseCase<List<Post>, NoParams> {
  final PostsRepository repository;

  GetAllPosts(this.repository);

  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) async {
    return await repository.getAllPosts();
  }
}
