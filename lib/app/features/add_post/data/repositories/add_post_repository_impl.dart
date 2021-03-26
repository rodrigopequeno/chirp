import 'package:chirp/app/core/models/post_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repositories/add_post_repository.dart';
import '../datasources/add_post_data_source.dart';

class AddPostRepositoryImpl implements AddPostRepository {
  final AddPostDataSource addPostDataSource;

  AddPostRepositoryImpl({required this.addPostDataSource});

  @override
  Future<Either<Failure, Unit>> addPost(PostModel addPostModel) async {
    try {
      await addPostDataSource.createPost(addPostModel);
      return const Right(unit);
    } catch (e) {
      return Left(SavePostFailure());
    }
  }
}
