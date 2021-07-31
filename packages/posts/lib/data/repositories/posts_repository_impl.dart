import 'package:core/error/exceptions.dart';
import 'package:core/error/failure.dart';
import 'package:core/models/post_model.dart';
import 'package:core/network/network_info.dart';
import 'package:core/utils/character_limit.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/posts_repository.dart';
import '../datasources/posts_local_data_source.dart';
import '../datasources/posts_remote_data_source.dart';

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
        localDataSource.cachePosts(remotePosts);
        final localPostsSave = await localDataSource.getPosts();
        final postsFilteredByCharacterLimit = (localPostsSave + remotePosts)
            .where((element) =>
                characterLimit.isWithinTheLimitPreview(element.content))
            .toList();
        return Right(postsFilteredByCharacterLimit);
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
