import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/core/usecases/usecase.dart';
import 'package:chirp/app/features/add_post/domain/entities/add_post.dart';
import 'package:chirp/app/features/add_post/domain/repositories/add_post_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreatePost implements UseCase<AddPost, Params> {
  final AddPostRepository repository;

  CreatePost(this.repository);

  @override
  Future<Either<Failure, AddPost>> call(Params params) async {
    return await repository.addPost(params.addPost);
  }
}

class Params extends Equatable {
  final AddPost addPost;

  const Params(this.addPost);

  @override
  List<Object?> get props => [addPost];
}
