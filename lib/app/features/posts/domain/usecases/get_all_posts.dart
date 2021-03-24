import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/core/usecases/usecase.dart';
import 'package:chirp/app/features/posts/domain/entities/posts.dart';
import 'package:chirp/app/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllPosts implements UseCase<Posts, NoParams> {
  final PostsRepository repository;

  GetAllPosts(this.repository);

  @override
  Future<Either<Failure, Posts>> call(NoParams params) async {
    return await repository.getAllPosts();
  }
}
