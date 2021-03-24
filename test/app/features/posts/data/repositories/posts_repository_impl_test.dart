import 'package:chirp/app/core/error/exceptions.dart';
import 'package:chirp/app/core/error/failure.dart';
import 'package:chirp/app/core/network/network_info.dart';
import 'package:chirp/app/features/posts/data/datasources/posts_local_data_source.dart';
import 'package:chirp/app/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:chirp/app/features/posts/data/models/post_model.dart';
import 'package:chirp/app/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:chirp/app/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostsRemoteDataSource extends Mock implements PostsRemoteDataSource {}

class MockPostsLocalDataSource extends Mock implements PostsLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late PostsRepository repositoryImpl;
  late MockPostsRemoteDataSource mockRemoteDataSource;
  late MockPostsLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUpAll(() {
    registerFallbackValue<List<PostModel>>(<PostModel>[]);
  });

  setUp(() {
    mockRemoteDataSource = MockPostsRemoteDataSource();
    mockLocalDataSource = MockPostsLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = PostsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );

    when(() => mockLocalDataSource.cachePosts(any()))
        .thenAnswer((_) async => {});
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getAllPosts', () {
    final dateTime = DateTime(2021, 03, 23, 09, 24, 01);
    final tPosts = [
      PostModel(
        id: '0',
        authorName: 'Rodrigo Pequeno',
        published: dateTime,
        content: 'Olá',
      )
    ];
    test('should check if the device is online', () async {
      when(() => mockRemoteDataSource.getAllPosts())
          .thenAnswer((_) async => tPosts);
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      repositoryImpl.getAllPosts();
      verify(() => mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          '''should return remote data when the call to remote data source is successful''',
          () async {
        when(() => mockRemoteDataSource.getAllPosts())
            .thenAnswer((_) async => tPosts);
        final result = await repositoryImpl.getAllPosts();
        verify(() => mockRemoteDataSource.getAllPosts());
        expect(result, equals(Right(tPosts)));
      });

      test('''
should cache the data locally when the call to remote data source is successful''',
          () async {
        when(() => mockRemoteDataSource.getAllPosts())
            .thenAnswer((_) async => tPosts);
        await repositoryImpl.getAllPosts();
        verify(() => mockRemoteDataSource.getAllPosts());
        verify(() => mockLocalDataSource.cachePosts(tPosts));
      });

      test('''
should return server failure when the call to remote data source is unsuccessful''',
          () async {
        when(() => mockRemoteDataSource.getAllPosts())
            .thenThrow(ServerException());
        final result = await repositoryImpl.getAllPosts();
        verify(() => mockRemoteDataSource.getAllPosts());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test('should return last locally cached data when cached data is present',
          () async {
        when(() => mockLocalDataSource.getLastPosts())
            .thenAnswer((_) async => tPosts);
        final result = await repositoryImpl.getAllPosts();
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getLastPosts());
        expect(result, equals(Right(tPosts)));
      });

      test('''
should return CacheFailure when there is no cached data present''', () async {
        when(() => mockLocalDataSource.getLastPosts())
            .thenThrow(NotFoundPostsCachedException());
        final result = await repositoryImpl.getAllPosts();
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getLastPosts());
        expect(result, equals(Left(NotFoundPostsCachedFailure())));
      });
    });
  });
}
