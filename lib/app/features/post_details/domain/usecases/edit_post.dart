import 'package:chirp/app/core/entities/post.dart';
import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/core/usecases/usecase.dart';
import 'package:chirp/app/features/post_details/domain/repositories/post_details_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class EditPost implements UseCase<Post, Params> {
  final PostDetailsRepository repository;

  EditPost(this.repository);

  @override
  Future<Either<Failure, Post>> call(Params params) async {
    return await repository.editPost(params.uid, params.newContent);
  }
}

class Params extends Equatable {
  final String uid;
  final String newContent;

  const Params({required this.uid, required this.newContent});

  @override
  List<Object?> get props => [uid, newContent];
}
