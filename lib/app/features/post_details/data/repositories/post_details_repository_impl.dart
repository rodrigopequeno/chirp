import 'package:chirp/app/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';

import 'package:chirp/app/core/entities/post.dart';
import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/features/post_details/data/datasources/post_details_data_source.dart';
import 'package:chirp/app/features/post_details/domain/repositories/post_details_repository.dart';

class PostDetailsRepositoryImpl implements PostDetailsRepository {
  PostDetailsDataSource detailsDataSource;

  PostDetailsRepositoryImpl({
    required this.detailsDataSource,
  });

  @override
  Future<Either<Failure, Unit>> deletePost(String uidPost) async {
    try {
      await detailsDataSource.deletePost(uidPost);
      return const Right(unit);
    } on NotFoundPostException {
      return Left(NotFoundPostFailure());
    } on DeletePostException {
      return Left(DeletePostFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> editPost(
      String uidPost, String newContent) async {
    try {
      final newPost = await detailsDataSource.editPost(uidPost, newContent);
      return Right(newPost);
    } on NotFoundPostException {
      return Left(NotFoundPostFailure());
    } on EditPostException {
      return Left(EditPostFailure());
    }
  }
}
