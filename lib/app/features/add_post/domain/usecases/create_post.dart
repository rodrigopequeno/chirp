import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/add_post_model.dart';
import '../repositories/add_post_repository.dart';

class CreatePost implements UseCase<void, Params> {
  final AddPostRepository repository;

  CreatePost(this.repository);

  @override
  Future<Either<Failure, Unit>> call(Params params) async {
    return await repository.addPost(params.addPost);
  }
}

class Params extends Equatable {
  final AddPostModel addPost;

  const Params(this.addPost);

  @override
  List<Object?> get props => [addPost];
}
