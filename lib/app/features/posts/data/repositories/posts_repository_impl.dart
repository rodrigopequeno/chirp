import 'package:chirp/app/core/error/exceptions.dart';
import 'package:chirp/app/core/network/network_info.dart';
import 'package:chirp/app/core/utils/character_limit.dart';
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
  CharacterLimit characterLimit;

  PostsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.characterLimit,
  });

  @override
  Future<Either<Failure, List<PostModel>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        final postsFilteredByCharacterLimit = remotePosts
            .where(
                (element) => characterLimit.isWithinTheLimit(element.content))
            .toList();
        localDataSource.cachePosts(postsFilteredByCharacterLimit);
        final localPostsSave = await localDataSource.getPosts();
        return Right(localPostsSave + remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachePosts();
        final localPostsSave = await localDataSource.getPosts();
        return Right(localPostsSave + localPosts);
      } on NotFoundPostsCachedException {
        return Left(NotFoundPostsCachedFailure());
      }
    }
  }
}
