import 'package:add_post/domain/repositories/add_post_repository.dart';
import 'package:core/error/failure.dart';
import 'package:core/models/post_model.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreatePost implements UseCase<void, Params> {
  final AddPostRepository repository;

  CreatePost(this.repository);

  @override
  Future<Either<Failure, Unit>> call(Params params) async {
    return await repository.addPost(params.addPost);
  }
}

class Params extends Equatable {
  final PostModel addPost;

  const Params(this.addPost);

  @override
  List<Object?> get props => [addPost];
}
