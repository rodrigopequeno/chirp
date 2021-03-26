import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/entities/post.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/post_details_repository.dart';

class EditPost implements UseCase<Post, ParamsEdit> {
  final PostDetailsRepository repository;

  EditPost(this.repository);

  @override
  Future<Either<Failure, Post>> call(ParamsEdit params) async {
    return await repository.editPost(params.uid, params.newContent);
  }
}

class ParamsEdit extends Equatable {
  final String uid;
  final String newContent;

  const ParamsEdit({required this.uid, required this.newContent});

  @override
  List<Object?> get props => [uid, newContent];
}
