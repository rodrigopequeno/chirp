import 'package:core/error/exceptions.dart';
import 'package:core/error/failure.dart';
import 'package:core/models/author_model.dart';
import 'package:core/models/post_model.dart';
import 'package:core/network/network_info.dart';
import 'package:core/utils/character_limit.dart';
import 'package:posts/data/datasources/posts_local_data_source.dart';
import 'package:posts/data/datasources/posts_remote_data_source.dart';
import 'package:posts/data/repositories/posts_repository_impl.dart';
import 'package:posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostsRemoteDataSource extends Mock implements PostsRemoteDataSource {}

class MockPostsLocalDataSource extends Mock implements PostsLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockCharacterLimit extends Mock implements CharacterLimit {}

void main() {
  late PostsRepository repositoryImpl;
  late MockPostsRemoteDataSource mockRemoteDataSource;
  late MockPostsLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockCharacterLimit mockCharacterLimit;

  setUpAll(() {
    registerFallbackValue<List<PostModel>>(<PostModel>[]);
  });

  setUp(() {
    mockRemoteDataSource = MockPostsRemoteDataSource();
    mockLocalDataSource = MockPostsLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockCharacterLimit = MockCharacterLimit();
    repositoryImpl = PostsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
      characterLimit: mockCharacterLimit,
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
    final tDateTime = DateTime(2021, 03, 23, 09, 24, 01);
    const tAuthor = AuthorModel(
        id: "75418de8-cf36-47c6-8850-3f958fb1b45d",
        authorName: "Rodrigo Pequeno",
        image: "https://randomuser.me/api/portraits/men/1.jpg");
    final tPosts = [
      PostModel(
        id: '2e9bf094-e494-4e22-ba10-dcf07ebfd18d',
        author: tAuthor,
        published: tDateTime,
        content: 'Hello',
      )
    ];
    test('should check if the device is online', () async {
      when(() => mockRemoteDataSource.getAllPosts())
          .thenAnswer((_) async => tPosts);
      when(() => mockLocalDataSource.getPosts()).thenAnswer((_) async => []);
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockCharacterLimit.isWithinTheLimitPreview(any()))
          .thenReturn(true);
      repositoryImpl.getAllPosts();
      verify(() => mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          '''should return remote data when the call to remote data source is successful''',
          () async {
        when(() => mockRemoteDataSource.getAllPosts())
            .thenAnswer((_) async => tPosts);
        when(() => mockLocalDataSource.getPosts()).thenAnswer((_) async => []);
        when(() => mockCharacterLimit.isWithinTheLimitPreview(any()))
            .thenReturn(true);
        final result = await repositoryImpl.getAllPosts();
        verify(() => mockRemoteDataSource.getAllPosts());
        expect(result, isA<Right<dynamic, List<PostModel>>>());
      });

      test('''
should cache the data locally when the call to remote data source is successful''',
          () async {
        when(() => mockRemoteDataSource.getAllPosts())
            .thenAnswer((_) async => tPosts);
        when(() => mockLocalDataSource.getPosts()).thenAnswer((_) async => []);
        when(() => mockCharacterLimit.isWithinTheLimitPreview(any()))
            .thenReturn(true);
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
        when(() => mockLocalDataSource.getCachePosts())
            .thenAnswer((_) async => tPosts);
        when(() => mockLocalDataSource.getPosts()).thenAnswer((_) async => []);
        final result = await repositoryImpl.getAllPosts();
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getCachePosts());
        expect(result, isA<Right<dynamic, List<PostModel>>>());
      });

      test('''
should return CacheFailure when there is no cached data present''', () async {
        when(() => mockLocalDataSource.getCachePosts())
            .thenThrow(NotFoundPostsCachedException());
        final result = await repositoryImpl.getAllPosts();
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getCachePosts());
        expect(result, equals(Left(NotFoundPostsCachedFailure())));
      });
    });
  });
}
