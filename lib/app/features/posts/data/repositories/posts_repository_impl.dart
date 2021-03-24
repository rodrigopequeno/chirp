import 'package:chirp/app/core/error/exceptions.dart';
import 'package:chirp/app/core/network/network_info.dart';
import 'package:chirp/app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';

import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/features/posts/data/datasources/posts_local_data_source.dart';
import 'package:chirp/app/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:chirp/app/features/posts/domain/repositories/posts_repository.dart';

class PostsRepositoryImpl extends PostsRepository {
  PostsRemoteDataSource remoteDataSource;
  PostsLocalDataSource localDataSource;
  NetworkInfo networkInfo;

  PostsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PostModel>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getLastPosts();
        return Right(localPosts);
      } on NotFoundPostsCachedException {
        return Left(NotFoundPostsCachedFailure());
      }
    }
  }
}
