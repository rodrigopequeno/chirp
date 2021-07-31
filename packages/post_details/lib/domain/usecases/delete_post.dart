import 'package:core/error/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repositories/post_details_repository.dart';

class DeletePost implements UseCase<Unit, ParamsDelete> {
  final PostDetailsRepository repository;

  DeletePost(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ParamsDelete params) async {
    return await repository.deletePost(params.uidPost);
  }
}

class ParamsDelete extends Equatable {
  final String uidPost;

  const ParamsDelete({required this.uidPost});

  @override
  List<Object?> get props => [uidPost];
}
