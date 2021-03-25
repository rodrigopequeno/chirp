import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/character_limit.dart';
import '../../domain/repositories/posts_repository.dart';
import '../datasources/posts_local_data_source.dart';
import '../datasources/posts_remote_data_source.dart';
import '../models/post_model.dart';

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
        return Right(localPostsSave + postsFilteredByCharacterLimit);
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
