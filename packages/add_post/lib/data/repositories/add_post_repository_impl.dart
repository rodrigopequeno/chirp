import 'package:add_post/data/datasources/add_post_data_source.dart';
import 'package:add_post/domain/repositories/add_post_repository.dart';
import 'package:core/error/failure.dart';
import 'package:core/models/post_model.dart';
import 'package:dartz/dartz.dart';

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
