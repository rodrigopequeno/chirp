import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/core/usecases/usecase.dart';
import 'package:chirp/app/features/add_post/data/models/add_post_model.dart';
import 'package:chirp/app/features/add_post/domain/repositories/add_post_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreatePost implements UseCase<void, Params> {
  final AddPostRepository repository;

  CreatePost(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.addPost(params.addPost);
  }
}

class Params extends Equatable {
  final AddPostModel addPost;

  const Params(this.addPost);

  @override
  List<Object?> get props => [addPost];
}
