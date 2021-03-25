import 'package:chirp/app/features/add_post/data/datasources/add_post_data_source.dart';
import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/features/add_post/data/models/add_post_model.dart';
import 'package:chirp/app/features/add_post/domain/repositories/add_post_repository.dart';
import 'package:dartz/dartz.dart';

class AddPostRepositoryImpl implements AddPostRepository {
  final AddPostDataSource addPostDataSource;

  AddPostRepositoryImpl({required this.addPostDataSource});

  @override
  Future<Either<Failure, Unit>> addPost(AddPostModel addPostModel) async {
    try {
      await addPostDataSource.createPost(addPostModel);
      return const Right(unit);
    } catch (e) {
      return Left(SavePostFailure());
    }
  }
}
