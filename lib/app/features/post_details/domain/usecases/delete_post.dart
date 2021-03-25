import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/core/usecases/usecase.dart';
import 'package:chirp/app/features/post_details/domain/repositories/post_details_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DeletePost implements UseCase<Unit, Params> {
  final PostDetailsRepository repository;

  DeletePost(this.repository);

  @override
  Future<Either<Failure, Unit>> call(Params params) async {
    return await repository.deletePost(params.uidPost);
  }
}

class Params extends Equatable {
  final String uidPost;

  const Params({required this.uidPost});

  @override
  List<Object?> get props => [uidPost];
}
